//
//  GyroscopeSensor.swift
//  mindLAMP Consortium
//

import CoreMotion

public class GyroscopeSensor: ISensorController {
    
    public var CONFIG = GyroscopeSensor.Config()
    private var motionManager: CMMotionManager
    public var LAST_DATA:CMGyroData?
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "core-motion-updates"
        return o
    }()
    
    public class Config: SensorConfig{
        /**
         * The defualt value of Android is 200000 microsecond.
         * The value means 5Hz
         */
        public var frequency:Int  = 5 // Hz
        public var period:Double  = 1 // min
        /**
         * Accelerometer threshold (Double).  Do not record consecutive points if
         * change in value of all axes is less than this.
         */
        public var threshold: Double = 0
        
        public var sensorObserver:GyroscopeObserver?
        
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
        
        public func apply(closure: (_ config: GyroscopeSensor.Config) -> Void) -> Self{
            closure(self)
            return self
        }
        
    }
    
    public convenience init(){
        self.init(GyroscopeSensor.Config())
    }
    
    public init(_ config:GyroscopeSensor.Config){
        self.CONFIG = config
        motionManager = CMMotionManager()
        if config.debug{ print("Gyroscope sensor is created.") }
    }
    
    public func start() {
        if self.motionManager.isGyroAvailable {
            self.motionManager.gyroUpdateInterval = 1.0/Double(CONFIG.frequency)
            self.motionManager.startGyroUpdates(to: opQueue) { (gyroScopeData, error) in
                
                guard let data = gyroScopeData else {
                    return
                }
                //                    let x = gyroData.rotationRate.x
                //                    let y = gyroData.rotationRate.y
                //                    let z = gyroData.rotationRate.z
                //                    if let lastData = self.LAST_DATA {
                //                        if self.CONFIG.threshold > 0 &&
                //                            abs(x - lastData.rotationRate.x) < self.CONFIG.threshold &&
                //                            abs(y - lastData.rotationRate.y) < self.CONFIG.threshold &&
                //                            abs(z - lastData.rotationRate.z) < self.CONFIG.threshold {
                //                                return
                //                        }
                //                    }
                //
                //                    self.LAST_DATA = gyroData
                self.CONFIG.sensorObserver?.onDataChanged(data: GyroscopeData(data.rotationRate))
            }
            
            if self.CONFIG.debug{ print( "Gyroscope sensor active: \(self.CONFIG.frequency) hz") }
        }
    }
    
    public func stop() {
        if self.motionManager.isGyroAvailable, self.motionManager.isGyroActive {
            self.motionManager.stopGyroUpdates()
            if self.CONFIG.debug{ print("Gyroscope sensor terminated") }
        }
    }
}
