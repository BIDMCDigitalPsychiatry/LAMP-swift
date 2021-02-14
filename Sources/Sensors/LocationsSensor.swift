import CoreLocation

public protocol LocationsObserver: class {
    func onError(_ errType: LocationErrorType)
}

public protocol LocationsDataObserver: class {
    func onLocationChanged(data: LocationsData)
}

public enum LocationErrorType {
    case notEnabled
    case denied
    case otherErrors(Error)
}


public class LocationsSensor: NSObject, ISensorController {

    public let locationManager = CLLocationManager()
    
    public var CONFIG: LocationsSensor.Config
    
    private var lastStoredTime: TimeInterval = Date().timeIntervalSince1970.advanced(by: -4 * 60)
    
    public class Config:SensorConfig {
        
        public weak var sensorObserver: LocationsObserver?
        public weak var locationDataObserver: LocationsDataObserver?
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
        
        // Do not start services that aren't available.
        if false == CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            CONFIG.sensorObserver?.onError(LocationErrorType.notEnabled)
            return
        }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestAlwaysAuthorization()
            return
        case .restricted, .denied:
            CONFIG.sensorObserver?.onError(LocationErrorType.denied)
            return
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            break
        @unknown default:
            break
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
            CONFIG.sensorObserver?.onError(LocationErrorType.denied)
            break
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let dataObserver = CONFIG.locationDataObserver else { return }
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
                    dataObserver.onLocationChanged(data: LocationsData(newestLocation, eventTime: newestLocation.timestamp) )
                    lastStoredTime = locationStamp
                }
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //let msg = String(format: Logs.Messages.location_error, error.localizedDescription)
        CONFIG.sensorObserver?.onError(LocationErrorType.otherErrors(error))
        if self.CONFIG.debug { print(error) }
    }
    
}

