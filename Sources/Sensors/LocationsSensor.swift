import CoreLocation

public struct LocationsData {

    public var timestamp: Double
    public var altitude:  Double
    public var latitude:  Double
    public var longitude: Double
    
    init(_ location: CLLocation, eventTime: Date?) {
        timestamp = eventTime != nil ? eventTime!.timeIntervalSince1970 * 1000 : Date().timeIntervalSince1970 * 1000
        altitude = location.altitude
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

public class GeofenceData: LampSensorCoreObject {
    
    public static let TABLE_NAME = "geofenceData"
    
    public var horizontalAccuracy: Double = 0
    public var verticalAccuracy: Double   = 0
    public var latitude:Double            = 0
    public var longitude:Double           = 0

    public var onExit:Bool  = false
    public var onEntry:Bool = false

    public var targetLatitude:Double  = 0
    public var targetLongitude:Double = 0
    public var targetRadius:Double    = 0
    public var identifier:String      = ""

    
    public override func toDictionary() -> Dictionary<String, Any> {
        var dict = super.toDictionary()
        dict["horizontalAccuracy"] = horizontalAccuracy
        dict["verticalAccuracy"]   = verticalAccuracy
        dict["latitude"]           = latitude
        dict["longitude"]          = longitude
        
        dict["onExit"]  = onExit
        dict["onEntry"] = onEntry

        dict["identifier"]         = identifier
        return dict
    }
}

public class HeadingData: LampSensorCoreObject {
    
    public static var TABLE_NAME = "headingData"

    public var magneticHeading: Double = 0
    public var trueHeading: Double = 0
    public var headingAccuracy: Double = 0
    public var x: Double = 0
    public var y: Double = 0
    public var z: Double = 0

    override public func toDictionary() -> Dictionary<String, Any> {
        var dict = super.toDictionary()
        dict["headingAccuracy"] = headingAccuracy
        dict["trueHeading"] = trueHeading
        dict["magneticHeading"] = magneticHeading
        dict["x"] = x
        dict["y"] = y
        dict["z"] = z
        return dict
    }

}

public class VisitData: LampSensorCoreObject {
    
    public static let TABLE_NAME = "visitData"
    
    public var horizontalAccuracy: Double = 0
    public var latitude:Double = 0
    public var longitude:Double = 0
    public var name:String = ""
    public var address:String = ""
    public var departure:Int64 = 0
    public var arrival:Int64 = 0
    
    public override func toDictionary() -> Dictionary<String, Any> {
        var dict = super.toDictionary()
        dict["horizontalAccuracy"] = horizontalAccuracy
        dict["latitude"] = latitude
        dict["longitude"] = longitude
        dict["name"] = name
        dict["address"] = address
        dict["departure"] = departure
        dict["arrival"] = arrival
        return dict
    }
}

public protocol LocationsObserver: class {
    func onLocationChanged(data: LocationsData)
}


public class LocationsSensor: NSObject, ISensorController {

    public let locationManager = CLLocationManager()
    
    public var CONFIG: LocationsSensor.Config
    
    private var lastStoredTime: TimeInterval = Date().timeIntervalSince1970.advanced(by: -4 * 60)
    
    public class Config:SensorConfig {
        
        public weak var sensorObserver: LocationsObserver?
        //public var geoFences: String? = nil; // TODO: convert the value to CLRegion
        public var statusGps = true
        public var minimumInterval = 0.0//in seconds
        
        public var accuracy: CLLocationAccuracy = kCLLocationAccuracyBestForNavigation

        public override init() {
            super.init()
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
            if let status = config["statusGps"] as? Bool {
                statusGps = status
            }
        }
        
        public func apply(closure:(_ config: LocationsSensor.Config ) -> Void ) -> Self {
            closure(self)
            return self
        }
    }
    
    public override convenience init() {
        self.init(LocationsSensor.Config())
    }
    
    public init(_ config:LocationsSensor.Config){
        self.CONFIG = config
        super.init()
        self.locationManager.delegate = self;
    }
    
    public func start() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestAlwaysAuthorization()
            return
        case .restricted, .denied:
            // Disable location features
            // disableMyLocationBasedFeatures()
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.gps_off)
            return
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
            // Enable basic location features
            // enableMyWhenInUseFeatures()
            break
        @unknown default:
            break
        }
        
        // Do not start services that aren't available.
        if false == CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.gps_off)
            return
        }
        
        self.startLocationServices()

    }
    
    
    public func stop() {
        self.stopLocationServices()

    }
    
    func startLocationServices() {
        #if os(iOS)
        locationManager.pausesLocationUpdatesAutomatically = false
        //locationManager.showsBackgroundLocationIndicator = false
        #endif
        locationManager.desiredAccuracy = CONFIG.accuracy
        locationManager.allowsBackgroundLocationUpdates = true
        // locationManager.distanceFilter = CONFIG.minGpsAccuracy // In meters.
        // Configure and start the service.
        // locationManager.activityType = CLActivityType.other

        if self.CONFIG.statusGps {
            locationManager.startUpdatingLocation()
            #if os(iOS)
            locationManager.startMonitoringSignificantLocationChanges()
            #endif
        }

    }
    
    func stopLocationServices(){
        if self.CONFIG.statusGps {
            locationManager.stopUpdatingLocation()
            #if os(iOS)
            locationManager.stopMonitoringSignificantLocationChanges()
            #endif
        }
    }
}

extension LocationsSensor: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.CONFIG.debug { print(#function) }
        switch status {
        case .authorizedAlways:
            self.start()
            break
        case .authorizedWhenInUse:
            self.start()
            break
        case .restricted, .denied:
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.gps_off)
            break
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let observer = CONFIG.sensorObserver else { return }
        let sortedLocations = locations.sorted { (l1, l2) -> Bool in
            return l1.timestamp.compare(l2.timestamp) != .orderedDescending
        }

        if let newestLocation = sortedLocations.last {

            if (newestLocation.horizontalAccuracy < 0) {
                return
            }
            if abs(newestLocation.timestamp.timeIntervalSinceNow) < 60 {
                let locationStamp = newestLocation.timestamp.timeIntervalSince1970
                if (locationStamp - lastStoredTime) > CONFIG.minimumInterval {
                    //self.saveLocations(newestLocation, eventTime: newestLocation.timestamp)
                    observer.onLocationChanged(data: LocationsData(newestLocation, eventTime: newestLocation.timestamp) )
                    lastStoredTime = locationStamp
                }
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //let msg = String(format: Logs.Messages.location_error, error.localizedDescription)
        //LMLogsManager.shared.addLogs(level: .warning, logs: msg)
        if self.CONFIG.debug { print(error) }
    }
    
}

