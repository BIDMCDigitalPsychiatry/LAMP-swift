//
//  Accelerometer.swift
//  mindLAMP Consortium
//
//

import Foundation
import CoreMotion

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
        public var sensorObserver: AccelerometerObserver?
        
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
                
                //                    let x = data.acceleration.x
                //                    let y = data.acceleration.y
                //                    let z = data.acceleration.z
                //                    if let lastValue = self.LAST_VALUE {
                //                        if self.CONFIG.threshold > 0 &&
                //                            abs(x - lastValue.acceleration.x) * 9.8 < self.CONFIG.threshold &&
                //                            abs(y - lastValue.acceleration.y) * 9.8 < self.CONFIG.threshold &&
                //                            abs(z - lastValue.acceleration.z) * 9.8 < self.CONFIG.threshold {
                //                            return
                //                        }
                //                    }
                //                    self.LAST_VALUE = data

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
