//
//  LocationsSensor.swift
//  mindLAMP Consortium
//
#if !os(watchOS)
import CoreLocation

public protocol LocationsObserver {
    func onLocationChanged(data: LocationsData)
}


public class LocationsSensor: NSObject, ISensorController {

    public let locationManager = CLLocationManager()
    
    public var CONFIG: LocationsSensor.Config
    
    private var lastStoredTime: TimeInterval = Date().timeIntervalSince1970.advanced(by: -4 * 60)
    
    public class Config:SensorConfig {
        
        public var sensorObserver: LocationsObserver?
        //public var geoFences: String? = nil; // TODO: convert the value to CLRegion
        public var statusGps = true
        public var minimumInterval = 0.0//in seconds

        
        public var accuracy: CLLocationAccuracy? = nil

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
            // Enable basic location features
            // enableMyWhenInUseFeatures()
            break
        @unknown default:
            break
        }
        
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
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
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation//kCLLocationAccuracyHundredMeters
        locationManager.allowsBackgroundLocationUpdates = true
        //locationManager.distanceFilter = CONFIG.minGpsAccuracy // In meters.
        // Configure and start the service.
        if #available(iOS 11.0, *) {
            locationManager.showsBackgroundLocationIndicator = false
        }
        
        if self.CONFIG.statusGps {
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }

    }
    
    func stopLocationServices(){
        if self.CONFIG.statusGps {
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoringSignificantLocationChanges()
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
                    self.saveLocations(locations, eventTime: nil)
                    lastStoredTime = locationStamp
                }
            }
        }
    }
    
    func saveLocations(_ locations: [CLLocation], eventTime:Date?){

        if let location = locations.last {
            CONFIG.sensorObserver?.onLocationChanged(data: LocationsData(location))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //let msg = String(format: Logs.Messages.location_error, error.localizedDescription)
        //LMLogsManager.shared.addLogs(level: .warning, logs: msg)
        if self.CONFIG.debug { print(error) }
    }
    
}
#endif
