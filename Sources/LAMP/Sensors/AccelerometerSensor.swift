import Foundation
import CoreMotion

public class AccelerometerData {
    
    public var timestamp: Double
    public var acceleration: CMAcceleration
    
    init(_ acceleration: CMAcceleration) {
        self.acceleration = acceleration
        timestamp = Date().timeIntervalSince1970 * 1000
    }
    
    init(_ acceleration: CMAcceleration, timeStamp: TimeInterval) {
        self.acceleration = acceleration
        self.timestamp = timeStamp * 1000
    }
}

public class AccelerometerSensor: ISensorController {
    
    /// config ///
    public var CONFIG = AccelerometerSensor.Config()
    
    private var motionManager: CMMotionManager
    public var LAST_VALUE: CMAccelerometerData?
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-updates"
        return o
    }()
    
    public class Config: SensorConfig{
        
        public var period: Double  = 1 // min
        public var frequency: Int = 5 // Hz
        /**
         * Accelerometer threshold (Double).  Do not record consecutive points if
         * change in value of all axes is less than this.
         */
        public var threshold: Double = 0
        public weak var sensorObserver: AccelerometerObserver?
        
        public override init() {
            super.init()
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
            if let period = config["period"] as? Double {
                self.period = period
            }
            
            if let threshold = config ["threshold"] as? Double {
                self.threshold = threshold
            }
            
            if let frequency = config["frequency"] as? Int {
                self.frequency = frequency
            }
        }
        
        public func apply(closure: (_ config: AccelerometerSensor.Config ) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    
    public convenience init() {
        self.init(AccelerometerSensor.Config())
    }
    
    public init(_ config:AccelerometerSensor.Config) {
        self.CONFIG = config
        motionManager = CMMotionManager()
        if config.debug { print("Accelerometer sensor is created.") }
    }
    
    public func start(){
        if motionManager.isAccelerometerAvailable {
            let handler: CMAccelerometerHandler = {(data: CMAccelerometerData?, error: Error?) -> Void in
                guard let data = data else {
                    return
                }
                self.CONFIG.sensorObserver?.onDataChanged(data: AccelerometerData(data.acceleration))
            }
            
            motionManager.accelerometerUpdateInterval = 1.0/Double(CONFIG.frequency)
            motionManager.startAccelerometerUpdates(to: opQueue, withHandler: handler)
        }
    }
    
    public func stop() {
        if self.motionManager.isAccelerometerAvailable, self.motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
}

extension CMSensorDataList: Sequence {
    public typealias Iterator = NSFastEnumerationIterator

    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self)
    }
}

public class LMSensorRecorder {
    
    //let activityManager = CMMotionActivityManager()
    let sensorRecorder: CMSensorRecorder
    //var recordingStartDate: Date?
    let duration: TimeInterval
    
    public init(_ duration: TimeInterval? = nil) {
//        self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: {(data: CMMotionActivity!) -> Void in
//
//        })
        self.duration = duration ?? 12.0 * 60.0 * 60.0 //in seconds //12 hours is the maximum
        sensorRecorder = CMSensorRecorder()
        //this is for prompting permission
        DispatchQueue.global(qos: .background).async {
            self.sensorRecorder.recordAccelerometer(forDuration: 1)
        }
    }
    
    public func startReadingAccelorometerData() {
        if CMSensorRecorder.isAccelerometerRecordingAvailable() {
            
            if CMSensorRecorder.authorizationStatus() == .authorized {
                print("Authorized.......")
                //if recordingStartDate == nil || recordingStartDate!.addingTimeInterval(duration) < Date() {
                    
                    DispatchQueue.global(qos: .background).async {
                        //self.recordingStartDate = Date()
                        self.sensorRecorder.recordAccelerometer(forDuration: self.duration)
                    }
                //}
                
            } else {
                print("not authorized")
            }
        } else {
            print("NOt available for recording")
        }
    }
    
    
    public func getRecordedData(from: Date, to: Date) -> [AccelerometerData]? {
        //if to < self.recordingStartDate!.addingTimeInterval(duration) {
            let startTime = from//self.lastFetchedDate ?? self.recordingStartDate!
            let endTime = to//startTime.addingTimeInterval(10 * 60)
            guard let sensorData = self.sensorRecorder.accelerometerData(from: startTime, to:endTime) else {
                //startReadingAccelorometerData()//TODO: no need this
                return nil
            }
            return sensorData.compactMap { (datum) -> AccelerometerData? in
                if let accdatum = datum as? CMRecordedAccelerometerData {
                    let accel = accdatum.acceleration
                    let t = accdatum.startDate.timeIntervalSince1970
                    return AccelerometerData(accel, timeStamp: t)
                }
                return nil
            }
    }
}
