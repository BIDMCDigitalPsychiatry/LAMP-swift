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

    var timer: Timer?
    public let locationManager = CLLocationManager()
    
    public var config: LocationsSensor.Config
    
    private var lastStoredTime: TimeInterval = Date().timeIntervalSince1970.advanced(by: -4 * 60)
    
    public class Config:SensorConfig {
        
        public weak var sensorObserver: LocationsObserver?
        public weak var locationDataObserver: LocationsDataObserver?
        //public var geoFences: String? = nil; // TODO: convert the value to CLRegion
        public var statusGps = true
        public var minimumInterval: Double {
            return 1.0 / activeFrequency
        }
        var activeFrequency: Double = 1
        public var frequency: Double = 1 { // Hz
            didSet {
                activeFrequency = min(frequency, 100.0)
            }
        }
        
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
        self.config = config
        super.init()
        self.locationManager.delegate = self;
    }
    
    public func start() {
        print("Staring location")
        // Do not start services that aren't available.
        if false == CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            config.sensorObserver?.onError(LocationErrorType.notEnabled)
            return
        }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestAlwaysAuthorization()
            return
        case .restricted, .denied:
            config.sensorObserver?.onError(LocationErrorType.denied)
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
    
    let queue = DispatchQueue(label: "LocationSensor", qos: .background, attributes: .concurrent)
    func startLocationServices() {
        #if os(iOS)
        locationManager.pausesLocationUpdatesAutomatically = false
        //locationManager.showsBackgroundLocationIndicator = false
        #endif
        locationManager.desiredAccuracy = config.accuracy
        locationManager.allowsBackgroundLocationUpdates = true
        // locationManager.distanceFilter = CONFIG.minGpsAccuracy // In meters.
        // Configure and start the service.
        // locationManager.activityType = CLActivityType.other

        if self.config.statusGps {
            locationManager.startUpdatingLocation()
            #if os(iOS)
            locationManager.startMonitoringSignificantLocationChanges()
            #endif
        }

        queue.async {
            let currentRunLoop = RunLoop.current
            self.timer = Timer.scheduledTimer(timeInterval: self.config.minimumInterval, target: self, selector: #selector(self.fetchLocation), userInfo: nil, repeats: true)
            currentRunLoop.add(self.timer!, forMode: .common)
            currentRunLoop.run()
        }
    }
    
    @objc
    func fetchLocation() {
        if self.config.statusGps {
            //locationManager.requestLocation()
            guard let newestLocation = locationManager.location else {
                locationManager.requestLocation()
                return
            }
            let timestamp = Date()
            let locationStamp = timestamp.timeIntervalSince1970
            if (locationStamp - lastStoredTime) >= config.minimumInterval {
                self.config.locationDataObserver?.onLocationChanged(data: LocationsData(newestLocation, eventTime: timestamp))
            }
        }
    }
    
    func stopLocationServices(){
        if self.config.statusGps {
            locationManager.stopUpdatingLocation()
            #if os(iOS)
            locationManager.stopMonitoringSignificantLocationChanges()
            #endif
            timer?.invalidate()
            timer = nil
        }
    }
}

extension LocationsSensor: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.config.debug { print(#function) }
        switch status {
        case .authorizedAlways:
            self.start()
            break
        case .authorizedWhenInUse:
            self.start()
            break
        case .restricted, .denied:
            config.sensorObserver?.onError(LocationErrorType.denied)
            break
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let dataObserver = config.locationDataObserver else { return }
        let sortedLocations = locations.sorted { (l1, l2) -> Bool in
            return l1.timestamp.compare(l2.timestamp) != .orderedDescending
        }
        if let newestLocation = sortedLocations.last {

            if (newestLocation.horizontalAccuracy < 0) {
                return
            }
            if abs(newestLocation.timestamp.timeIntervalSinceNow) < 60 {
                let locationStamp = newestLocation.timestamp.timeIntervalSince1970
                if (locationStamp - lastStoredTime) > config.minimumInterval {
                    //self.saveLocations(newestLocation, eventTime: newestLocation.timestamp)
                    dataObserver.onLocationChanged(data: LocationsData(newestLocation, eventTime: newestLocation.timestamp) )
                    lastStoredTime = locationStamp
                }
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //let msg = String(format: Logs.Messages.location_error, error.localizedDescription)
        config.sensorObserver?.onError(LocationErrorType.otherErrors(error))
        if self.config.debug { print(error) }
    }
    
}

