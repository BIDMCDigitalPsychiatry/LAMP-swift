//
//  PedometerSensor.swift
//  mindLAMP Consortium
//

import CoreMotion

public class PedometerSensor: ISensorController {
    
    public static let TAG = "LAMP::Pedometer"
    public var CONFIG: PedometerSensor.Config = Config()
    
    var pedometer: CMPedometer
    
    public class Config: SensorConfig {
        
        public weak var sensorObserver: PedometerObserver?
        
        public override init() {
            super.init()
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
        }
        
        public func apply(closure:(_ config: PedometerSensor.Config) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    
    public convenience init() {
        self.init(PedometerSensor.Config())
    }
    
    public init(_ config: PedometerSensor.Config) {
        CONFIG = config
        pedometer = CMPedometer()
    }
    
    public func removeSavedTimestamps() {
        Utils.shared.removeAllSavedDates()
    }
    
    public func start() {

        if !CMPedometer.isPaceAvailable(){
            print(PedometerSensor.TAG, "Pace is not available.")
        }
        
        if !CMPedometer.isCadenceAvailable(){
            print(PedometerSensor.TAG, "Cadence is not available.")
        }
        
        if !CMPedometer.isDistanceAvailable(){
            print(PedometerSensor.TAG, "Distance is not available.")
        }
        
        if !CMPedometer.isFloorCountingAvailable(){
            print(PedometerSensor.TAG, "Floor Counting is not available.")
        }
        
        if !CMPedometer.isPedometerEventTrackingAvailable(){
            print(PedometerSensor.TAG, "Pedometer Event Tracking is not available.")
        }
        
        if CMPedometer.isStepCountingAvailable(){
            let startTime = Utils.shared.getHealthKitLaunchedTimestamp()
            pedometer.startUpdates(from: startTime) { [weak self] (pedometerData, error) in
                // save pedometer data
                if let pedoData = pedometerData {
                    let data = PedometerData()
                    data.startDate = pedoData.startDate.timeInMilliSeconds
                    data.endDate = pedoData.endDate.timeInMilliSeconds
                    data.numberOfSteps = pedoData.numberOfSteps.intValue
                    if let currentCadence = pedoData.currentCadence{
                        data.currentCadence = currentCadence.doubleValue
                    }
                    if let currentPace = pedoData.currentPace{
                        data.currentPace = currentPace.doubleValue
                    }
                    if let distance = pedoData.distance{
                        data.distance = distance.doubleValue
                    }
                    if let averageActivePace = pedoData.averageActivePace{
                        data.averageActivePace = averageActivePace.doubleValue
                    }
                    if let floorsAscended = pedoData.floorsAscended{
                        data.floorsAscended = floorsAscended.intValue
                    }
                    if let floorsDescended = pedoData.floorsDescended {
                        data.floorsDescended = floorsDescended.intValue
                    }
                    
                    self?.CONFIG.sensorObserver?.onPedometerChanged(data: data)

                }
            }
        } else {
            //ToDo: Throw error once and stop invoking pedometer and remove this sensor from sensormanager to not throw again
            print(PedometerSensor.TAG, "Step Counting is not available.")
        }
    }
    
    public func stop() {
        pedometer.stopUpdates()
    }
}

public protocol PedometerObserver: class {
    func onPedometerChanged(data: PedometerData)
}


