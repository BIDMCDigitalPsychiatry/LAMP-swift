import CoreMotion

public class PedometerData: LampSensorCoreObject {

    public var startDate: Double = 0
    public var endDate: Double  = 0
    public var value: Double  = 0
    public var type: String?
    public var unit: String?
    public var source: String?
    
    public var timestamp: Double {
        return endDate
    }
    
    public enum SensorType: String {
        case step_count
        case distance
        case cadence
        case floors_ascended
        case floors_descended
        case average_active_pace
        case pace
        
        var unit: String {
            switch self {
                
            case .step_count:
                return "count"
            case .distance:
                return "meter"
            case .cadence:
                return "steps per minute"
            case .floors_ascended:
                return "count"
            case .floors_descended:
                return "count"
            case .average_active_pace:
                return "seconds per meter"
            case .pace:
                return "seconds per meter"
            }
        }
    }
}

public class PedometerSensor: ISensorController {
    
    public static let TAG = "LAMP::Pedometer"
    public var config: PedometerSensor.Config = Config()
    
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
        self.config = config
        pedometer = CMPedometer()
    }
    
    public func removeSavedTimestamps() {
        Utils.shared.removeAllSavedDates()
    }
    
    public func start() {
        print("starting pedo")
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
        
        if CMPedometer.isStepCountingAvailable() {

            pedometer.startEventUpdates { (event, error) in
                let startTime = Calendar.current.startOfDay(for: Date())
                self.pedometer.queryPedometerData(from: startTime, to: Date()) { [weak self] (pedometerData, error) in
                    if let pedoData = pedometerData {
                        //CADENCE
                        //https://github.com/BIDMCDigitalPsychiatry/LAMP-platform/issues/503#issuecomment-1065139118
                        //cadence has different units, we should convert it, specifically, @jijopulikkottil, please convert it to steps per minute on iOS (by multiplying x 60).
                        if let currentCadence = pedoData.currentCadence?.doubleValue {
                            let cadence = currentCadence * 60
                            self?.postSensorType(type: .cadence, value: cadence, pedoData: pedoData)
                        }
                        //Step Count
                        if pedoData.numberOfSteps.intValue > 0 {
                            self?.postSensorType(type: .step_count, value: Double(pedoData.numberOfSteps.intValue), pedoData: pedoData)
                        }
                        //Distance
                        if let distance = pedoData.distance?.doubleValue {
                            self?.postSensorType(type: .distance, value: distance, pedoData: pedoData)
                        }
                        //Pace
                        if let pace = pedoData.currentPace?.doubleValue {
                            self?.postSensorType(type: .pace, value: pace, pedoData: pedoData)
                        }
                        //averageActivePace
                        if let avgPace = pedoData.averageActivePace?.doubleValue {
                            self?.postSensorType(type: .average_active_pace, value: avgPace, pedoData: pedoData)
                        }
                        //floors
                        if let floor = pedoData.floorsAscended?.intValue {
                            self?.postSensorType(type: .floors_ascended, value: Double(floor), pedoData: pedoData)
                        }
                        if let floor = pedoData.floorsDescended?.intValue {
                            self?.postSensorType(type: .floors_descended, value: Double(floor), pedoData: pedoData)
                        }
                    }
                }
            }
        } else {
            //ToDo: Throw error once and stop invoking pedometer and remove this sensor from sensormanager to not throw again
            print(PedometerSensor.TAG, "Step Counting is not available.")
        }
    }
    
    public func stop() {
        pedometer.stopEventUpdates()
    }
    private func postSensorType(type: PedometerData.SensorType, value: Double, pedoData: CMPedometerData) {
        let data = PedometerData()
        data.startDate = pedoData.startDate.timeIntervalSince1970 * 1000
        data.endDate = pedoData.endDate.timeIntervalSince1970 * 1000
        data.value = value
        data.type = type.rawValue
        data.unit = type.unit
        data.source = "daily pedometer" //#730
        self.config.sensorObserver?.onPedometerChanged(data: data)
    }
}

public protocol PedometerObserver: AnyObject {
    func onPedometerChanged(data: PedometerData)
}
