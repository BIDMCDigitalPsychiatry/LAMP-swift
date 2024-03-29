#if canImport(UIKit)
import Foundation
import CoreMotion
import UIKit

//https://developer.apple.com/documentation/coremotion/cmmotionmanager?language=objc
//https://developer.apple.com/videos/play/wwdc2017/704/ 10:00
public protocol MotionObserver: AnyObject {
    func onDataChanged(data: MotionData)
}

public protocol AccelerometerObserver: AnyObject {
    func onDataChanged(data: AccelerometerData)
}

public protocol GyroscopeObserver: AnyObject {
    func onDataChanged(data: GyroscopeData)
}

public protocol MagnetometerObserver: AnyObject {
    func onDataChanged(data:MagnetometerData)
}

public protocol SensorStore: AnyObject {
    func timeToStore()
}

public class MotionManager: ISensorController {
    
    /// config ///
    public var config = MotionManager.Config()
    private var lastSavedTimeStamp: Double = 0.0
    private var isCollecting = true
    private var motionManager: CMMotionManager
    var motionUpdateTimer: Timer?
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-MotionManager"
        return o
    }()

    public class Config: SensorConfig {
        
        public var collectionPeriod: Double = 0 // min
        public var pausePeriod: Double  = 0 // min
        
        var activeFrequency: Double = 5
        public var frequency: Double? = nil { // Hz
            didSet {
                guard let frquenctValue = frequency, frquenctValue > 0.0 else { return }
                activeFrequency = min(frquenctValue, 5.0)
            }
        }
        /**
         * Accelerometer threshold (Double).  Do not record consecutive points if
         * change in value of all axes is less than this.
         */
        public var threshold: Double = 0
        public var sensorTimerDataStoreInterval: Double = 5.0 * 60.0
        
        public weak var accelerometerObserver: AccelerometerObserver? = nil
        public weak var gyroObserver: GyroscopeObserver? = nil
        public weak var magnetoObserver: MagnetometerObserver? = nil
        public weak var motionObserver: MotionObserver? = nil
        
        public weak var sensorTimerDelegate: SensorStore? = nil
        
        public override init() {
            super.init()
        }
        
//        public override func set(config: Dictionary<String, Any>) {
//            super.set(config: config)
//            if let period = config["period"] as? Double {
//                self.period = period
//            }
//            
//            if let threshold = config ["threshold"] as? Double {
//                self.threshold = threshold
//            }
//            
//            if let frequency = config["frequency"] as? Double {
//                self.frequency = frequency
//            }
//        }
        
        public func apply(closure: (_ config: MotionManager.Config ) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    private var shouldRestartMotionUpdates = false
    
    public convenience init() {
        self.init(MotionManager.Config())
        print("init motion")
    }

    deinit {
        #if os(iOS)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
        #endif
    }
    
    public init(_ config: MotionManager.Config) {
        self.config = config
        motionManager = CMMotionManager()
        if config.debug { print("Accelerometer sensor is created.") }
        
        #if os(iOS)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #endif
    }
    
    @objc private func appDidEnterBackground() {
        self.restartMotionUpdates()
    }
    
    @objc private func appDidBecomeActive() {
        self.restartMotionUpdates()
    }
    
    public func start() {
        self.shouldRestartMotionUpdates = true
        self.restartMotionUpdates()
        print("starting motion")
        // Configure a timer to fetch the data.
//        self.motionUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / Double(CONFIG.frequency), repeats: true, block: { (timer1) in
//            // Get the motion data.
//            self.runCount += 1
//            if let dataAcc = self.motionManager.accelerometerData {
//                self.CONFIG.accelerometerObserver?.onDataChanged(data: AccelerometerData(dataAcc.acceleration))
//            }
//            if let dataMag = self.motionManager.magnetometerData {
//                self.CONFIG.magnetoObserver?.onDataChanged(data: MagnetometerData(dataMag.magneticField))
//            }
//            if let dataGyro = self.motionManager.gyroData {
//                self.CONFIG.gyroObserver?.onDataChanged(data: GyroscopeData(dataGyro.rotationRate))
//            }
//            if let dataMotion = self.motionManager.deviceMotion {
//                self.CONFIG.motionObserver?.onDataChanged(data: MotionData(dataMotion))
//            }
//            if self.runCount > Double(self.CONFIG.frequency) * self.CONFIG.sensorTimerDataStoreInterval {
//                self.CONFIG.sensorTimerDelegate?.timeToStore()
//                self.runCount = 0
//            }
//        })
    }
    
    public func stop() {
        self.shouldRestartMotionUpdates = false
        
        stopUpdates()
        motionUpdateTimer?.invalidate()
        motionUpdateTimer = nil
        
        
    }
    var runCount = 0.0
    public func restartMotionUpdates() {
        guard self.shouldRestartMotionUpdates else { return }
        
        self.motionManager.accelerometerUpdateInterval = 1.0 / Double (config.activeFrequency)
        self.motionManager.gyroUpdateInterval = 1.0 / Double (config.activeFrequency)
        self.motionManager.magnetometerUpdateInterval = 1.0 / Double (config.activeFrequency)
        self.motionManager.deviceMotionUpdateInterval = 1.0 / Double (config.activeFrequency)
        
        stopUpdates()
        print("fire secods = \(Double(self.config.activeFrequency) * self.config.sensorTimerDataStoreInterval)")
        startUpdates()
    }
    
    private func stopUpdates() {
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopMagnetometerUpdates()
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    private func startUpdates() {
        if config.accelerometerObserver != nil {
            if config.motionObserver != nil {
                self.motionManager.startAccelerometerUpdates()
            } else {
                
                self.motionManager.startAccelerometerUpdates(to: opQueue) { (accelData, error) in
                    
                    if false == self.collectingData() { return }
                    
                    if let dataAcc = accelData {
                        self.config.accelerometerObserver?.onDataChanged(data: AccelerometerData(dataAcc.acceleration))
                    }
                    self.runCount += 1
                    //("runCount = \(self.runCount)")
                    if self.runCount > Double(self.config.activeFrequency) * self.config.sensorTimerDataStoreInterval {
                        self.runCount = 0
                        self.config.sensorTimerDelegate?.timeToStore()
                    }
                }
            }
        }
        
        if config.accelerometerObserver != nil && config.motionObserver != nil {
            self.motionManager.startAccelerometerUpdates()
        }
        if config.gyroObserver != nil {
            self.motionManager.startGyroUpdates()
        }
        if config.magnetoObserver != nil {
            self.motionManager.startMagnetometerUpdates()
        }
        
        if config.motionObserver != nil {
            self.motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryCorrectedZVertical, to: opQueue) { (deviceMotion, error) in

                if false == self.collectingData() { return }
                
                if let dataAcc = self.motionManager.accelerometerData {
                    self.config.accelerometerObserver?.onDataChanged(data: AccelerometerData(dataAcc.acceleration))
                }
                if let dataMag = self.motionManager.magnetometerData {
                    self.config.magnetoObserver?.onDataChanged(data: MagnetometerData(dataMag.magneticField))
                }
                if let dataGyro = self.motionManager.gyroData {
                    self.config.gyroObserver?.onDataChanged(data: GyroscopeData(dataGyro.rotationRate))
                }
                if let dataMotion = deviceMotion {
                    self.config.motionObserver?.onDataChanged(data: MotionData(dataMotion, timeInterval: Date().timeIntervalSince1970))
                }
                
                self.runCount += 1
                if self.runCount > Double(self.config.activeFrequency) * self.config.sensorTimerDataStoreInterval {
                    self.runCount = 0
                    self.config.sensorTimerDelegate?.timeToStore()
                }
            }
        }
        
    }
    
    private func collectingData() -> Bool {
        let currentTimeInterval = Date().timeIntervalSince1970
        
        if self.config.pausePeriod > 0 {
            if self.lastSavedTimeStamp < 1 {
                //("data collection started %@", Date())
                self.lastSavedTimeStamp = currentTimeInterval
            }
            // we should pause after 'collectionPeriod' minutes of data collection
            if self.isCollecting {
                if currentTimeInterval > self.lastSavedTimeStamp + (self.config.collectionPeriod * 60) {
                    self.isCollecting = false
                    self.lastSavedTimeStamp = currentTimeInterval
                    //("data collection paused %@", Date())
                    return false
                } else {
                    
                }
            }
            // we should resume after 'pausePeriod' minutes of idle
            else {
                if currentTimeInterval > self.lastSavedTimeStamp + (self.config.pausePeriod * 60) {
                    self.isCollecting = true
                    self.lastSavedTimeStamp = currentTimeInterval
                    //("data collection resumed %@", Date())
                } else {
                    return false
                }
            }
        }
        return true
    }
}
#endif
