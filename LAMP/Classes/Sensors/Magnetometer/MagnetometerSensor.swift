//
//  MagnetometerSensor.swift
//  mindLAMP Consortium
//

import CoreMotion

public class MagnetometerSensor: ISensorController {
    
    public var CONFIG = Config()
    var motionManager: CMMotionManager
    var LAST_DATA: CMMagneticField?
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-updates"
        return o
    }()
    //var LAST_SAVE:Double = Date().timeIntervalSince1970
    
    public class Config: SensorConfig {
        /**
         * For real-time observation of the sensor data collection.
         */
        public weak var sensorObserver: MagnetometerObserver?
        
        /**
         * Magnetometer frequency in hertz per second: e.g.
         *
         * 0 - fastest
         * 1 - sample per second
         * 5 - sample per second
         * 20 - sample per second
         */
        public var frequency: Int = 5
        
        /**
         * Period to save data in minutes. (optional)
         */
        public var period: Double = 1
        
        /**
         * Magnetometer threshold (float).  Do not record consecutive points if
         * change in value is less than the set value.
         */
        public var threshold: Double = 0.0
        
        public override init() {
            super.init()
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
            
            if let frequency = config["frequency"] as? Int {
                self.frequency = frequency
            }
            
            if let period = config["period"] as? Double {
                self.period = period
            }
            
            if let threshold = config["threshold"] as? Double {
                self.threshold = threshold
            }
        }
        
        public func apply(closure:(_ config: MagnetometerSensor.Config) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    
    public convenience init() {
        self.init(MagnetometerSensor.Config())
    }
    
    public init(_ config:MagnetometerSensor.Config) {
        self.CONFIG = config
        motionManager = CMMotionManager()
        if config.debug{ print("Magnetometer sensor is created. ") }
    }
    
    public func start() {
        if self.motionManager.isMagnetometerAvailable && !self.motionManager.isMagnetometerActive {
            self.motionManager.magnetometerUpdateInterval = 1.0/Double(CONFIG.frequency)
            self.motionManager.startMagnetometerUpdates(to: opQueue) { (magnetometerData, error) in
                
                guard let data = magnetometerData else {
                    return
                }
                //                    let x = magData.magneticField.x
                //                    let y = magData.magneticField.y
                //                    let z = magData.magneticField.z
                //                    if let lastData = self.LAST_DATA {
                //                        if self.CONFIG.threshold > 0 &&
                //                            abs(x - lastData.x) < self.CONFIG.threshold &&
                //                            abs(y - lastData.y) < self.CONFIG.threshold &&
                //                            abs(z - lastData.z) < self.CONFIG.threshold {
                //                            return
                //                        }
                //                    }
                //                    self.LAST_DATA = magData.magneticField
                self.CONFIG.sensorObserver?.onDataChanged(data: MagnetometerData(data.magneticField))
            }
        }
    }
    
    public func stop() {
        if motionManager.isMagnetometerAvailable && motionManager.isMagnetometerActive {
            motionManager.stopMagnetometerUpdates()
        }
    }
}
