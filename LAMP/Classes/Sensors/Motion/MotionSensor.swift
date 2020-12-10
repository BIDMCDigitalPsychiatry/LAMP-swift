//
//  MotionSensor.swift
//  
//
//  mindLAMP Consortium
//
import Foundation
import CoreMotion
import UIKit
//https://developer.apple.com/documentation/coremotion/cmmotionmanager?language=objc
//https://developer.apple.com/videos/play/wwdc2017/704/ 10:00

public class MotionSensor: ISensorController {
    
    /// config ///
    public var CONFIG = MotionSensor.Config()
    
    private var motionManager: CMMotionManager
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-updates"
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
        public var sensorObserver: MotionObserver?
        
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
                self.CONFIG.sensorObserver?.onDataChanged(data: MotionData(data))
            }
            
            motionManager.deviceMotionUpdateInterval = 1.0/Double(CONFIG.frequency)
            motionManager.startDeviceMotionUpdates(to: opQueue, withHandler: handler)
            if self.CONFIG.debug{ print( "DeviceMotion sensor active: \(self.CONFIG.frequency) hz") }
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
    
    public init(_ config:MotionSensor.Config) {
        self.CONFIG = config
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
