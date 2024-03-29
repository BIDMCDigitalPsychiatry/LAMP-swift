#if canImport(UIKit)
import Foundation
import CoreMotion
import UIKit
//https://developer.apple.com/documentation/coremotion/cmmotionmanager?language=objc
//https://developer.apple.com/videos/play/wwdc2017/704/ 10:00

public struct DeviceAttitude {
    public var roll: Double
    public var pitch: Double
    public var yaw: Double
}

public class MotionData {
    
    public var timestamp: Double
    
    public var acceleration: CMAcceleration
    public var rotationRate: CMRotationRate
    public var magneticField: CMMagneticField
    public var gravity: CMAcceleration
    public var deviceAttitude: DeviceAttitude
    
    init(_ deviceMotion: CMDeviceMotion, timeInterval: Double) {
        
        timestamp = timeInterval * 1000
        self.acceleration = deviceMotion.userAcceleration
        self.rotationRate = deviceMotion.rotationRate
        self.magneticField = deviceMotion.magneticField.field//we can check accuracy here
        self.gravity = deviceMotion.gravity
        self.deviceAttitude = DeviceAttitude(roll: deviceMotion.attitude.roll, pitch: deviceMotion.attitude.pitch, yaw: deviceMotion.attitude.yaw)
    }
}

public class MotionSensor: ISensorController {
    
        /// config ///
    public var config = MotionSensor.Config()
    private var lastSavedTimeStamp: Double = 0.0
    private var isCollecting = true
    private var motionManager: CMMotionManager
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-updates"
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
        public var sensorObserver: MotionObserver?
        
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
        
        public func apply(closure: (_ config: MotionSensor.Config ) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    
    
    
    private var shouldRestartMotionUpdates = false
    deinit {
        #if os(iOS)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
        #elseif os(watchOS)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.NSExtensionHostDidEnterBackground,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.NSExtensionHostDidBecomeActive,
                                                  object: nil)
        #endif
    }

    @objc private func appDidEnterBackground() {
        self.restartMotionUpdates()
    }
    
    @objc private func appDidBecomeActive() {
        self.restartMotionUpdates()
    }
    
    private func restartMotionUpdates() {
        guard self.shouldRestartMotionUpdates else { return }
        
        if self.motionManager.isDeviceMotionAvailable {
            self.motionManager.startDeviceMotionUpdates()
            
            let handler: CMDeviceMotionHandler = {(data: CMDeviceMotion?, error: Error?) -> Void in
                guard let data = data else {
                    return
                }
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
                            return
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
                            return
                        }
                    }
                }
                
                self.config.sensorObserver?.onDataChanged(data: MotionData(data, timeInterval: currentTimeInterval))
            }
            
            motionManager.deviceMotionUpdateInterval = 1.0/Double(config.activeFrequency)
            motionManager.startDeviceMotionUpdates(to: opQueue, withHandler: handler)
            if self.config.debug{ print( "DeviceMotion sensor active: \(self.config.activeFrequency) hz") }
        }
    }
    
    
    public convenience init() {
        self.init(MotionSensor.Config())
        
        #if os(iOS)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        #elseif os(watchOS)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: NSNotification.Name.NSExtensionHostDidEnterBackground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: NSNotification.Name.NSExtensionHostDidBecomeActive,
                                               object: nil)
        #endif
        
    }
    
    public init(_ config: MotionSensor.Config) {
        self.config = config
        motionManager = CMMotionManager()
        if config.debug { print("Accelerometer sensor is created.") }
    }
    
    public func start() {
        self.shouldRestartMotionUpdates = true
        self.restartMotionUpdates()
    }
    
    public func stop() {
        self.shouldRestartMotionUpdates = false
        if motionManager.isDeviceMotionAvailable && motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

#endif
