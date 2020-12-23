#if canImport(UIKit)
import Foundation
import CoreMotion
import UIKit

//https://developer.apple.com/documentation/coremotion/cmmotionmanager?language=objc
//https://developer.apple.com/videos/play/wwdc2017/704/ 10:00
public protocol MotionObserver: class {
    func onDataChanged(data: MotionData)
}

public protocol AccelerometerObserver: class {
    func onDataChanged(data: AccelerometerData)
}

public protocol GyroscopeObserver: class {
    func onDataChanged(data: GyroscopeData)
}

public protocol MagnetometerObserver: class {
    func onDataChanged(data:MagnetometerData)
}

public protocol SensorStore: class {
    func timeToStore()
}

public class MotionManager: ISensorController {
    
    /// config ///
    public var CONFIG = MotionManager.Config()
    
    private var motionManager: CMMotionManager
    var motionUpdateTimer: Timer?
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-MotionManager"
        return o
    }()

    public class Config: SensorConfig {
        
        public var period: Double  = 1 // min
        public var frequency: Int = 5 // Hz
        /**
         * Accelerometer threshold (Double).  Do not record consecutive points if
         * change in value of all axes is less than this.
         */
        public var threshold: Double = 0
        public var sensorTimerDataStoreInterval: Double = 10.0 * 60.0
        
        public weak var accelerometerObserver: AccelerometerObserver?
        public weak var gyroObserver: GyroscopeObserver?
        public weak var magnetoObserver: MagnetometerObserver? = nil
        public weak var motionObserver: MotionObserver?
        public weak var sensorTimerDelegate: SensorStore?
        
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
        
        public func apply(closure: (_ config: MotionManager.Config ) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    private var shouldRestartMotionUpdates = false
    
    public convenience init() {
        self.init(MotionManager.Config())
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
        self.CONFIG = config
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
//
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
        
        self.motionManager.accelerometerUpdateInterval = 1.0 / Double (CONFIG.frequency)
        self.motionManager.gyroUpdateInterval = 1.0 / Double (CONFIG.frequency)
        self.motionManager.magnetometerUpdateInterval = 1.0 / Double (CONFIG.frequency)
        self.motionManager.deviceMotionUpdateInterval = 1.0 / Double (CONFIG.frequency)
        
        stopUpdates()
        startUpdates()
    }
    
    private func stopUpdates() {
        self.motionManager.stopGyroUpdates()
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopMagnetometerUpdates()
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    private func startUpdates() {
        if CONFIG.accelerometerObserver != nil {
            self.motionManager.startAccelerometerUpdates()
        }
        if CONFIG.gyroObserver != nil {
            self.motionManager.startGyroUpdates()
        }
        if CONFIG.magnetoObserver != nil {
            self.motionManager.startMagnetometerUpdates()
        }
//        if CONFIG.motionObserver != nil {
//            self.motionManager.startDeviceMotionUpdates()
//        }
        self.motionManager.startDeviceMotionUpdates(to: opQueue) { (deviceMotion, error) in
            
            if let dataAcc = self.motionManager.accelerometerData {
                self.CONFIG.accelerometerObserver?.onDataChanged(data: AccelerometerData(dataAcc.acceleration))
            }
            if let dataMag = self.motionManager.magnetometerData {
                self.CONFIG.magnetoObserver?.onDataChanged(data: MagnetometerData(dataMag.magneticField))
            }
            if let dataGyro = self.motionManager.gyroData {
                self.CONFIG.gyroObserver?.onDataChanged(data: GyroscopeData(dataGyro.rotationRate))
            }
            if let dataMotion = deviceMotion {
                self.CONFIG.motionObserver?.onDataChanged(data: MotionData(dataMotion))
            }

            if self.runCount > Double(self.CONFIG.frequency) * self.CONFIG.sensorTimerDataStoreInterval {
                self.runCount = 0
                self.CONFIG.sensorTimerDelegate?.timeToStore()
            }
            self.runCount += 1
        }
    }
}
#endif
