import Foundation

protocol TextPresentation {
    var stringValue: String? {get}
}


public protocol ISensorController {
    var  id: String {get}
    func start()
    func stop()
    var notificationCenter: NotificationCenter {get}
}

extension ISensorController {
    public var notificationCenter: NotificationCenter {
        return NotificationCenter.default
    }
    
    public var  id: String {
        return UUID.init().uuidString
    }
}

public class LampSensorCoreObject {
    
    public var timestampInternal: Int64 = Int64(Date().timeIntervalSince1970*1000)
    open func toDictionary() -> Dictionary<String, Any> {
        let dict = ["timestamp": timestampInternal]
        return dict
    }
    public init() {}
}


open class SensorConfig{
    
    public var enabled: Bool    = false
    public var debug: Bool      = false
    public var label: String    = ""
    public var deviceId: String = ""
    
    public init(){
        
    }
    
    public convenience init(_ config:Dictionary<String,Any>){
        self.init()
        self.set(config: config)
    }
    
    open func set(config:Dictionary<String,Any>){
        if let enabled = config["enabled"] as? Bool{
            self.enabled = enabled
        }
        
        if let debug = config["debug"] as? Bool {
            self.debug = debug
        }
        
        if let label = config["label"] as? String {
            self.label = label
        }

        if let deviceId = config["deviceId"] as? String {
            self.deviceId = deviceId
        }
    }
}

public class SensorManager {
    
    /**
     * Singleton
     */
    public static let shared = SensorManager()
    
    public init() {
        
    }
    
    public var sensors: Array<ISensorController> = []
    
    public func addSensors(_ sensors: [ISensorController]){
        for sensor in sensors {
            self.addSensor(sensor)
        }
    }
    
    public func addSensor(_ sensor: ISensorController) {
        sensors.append(sensor)
    }
    
    
//    public func removeSensors(with type: AnyClass){
//        for sensor in sensors {
//            if let index = sensors.firstIndex(of: sensor) {
//                if type(of: sensor) == type(of: type) {
//                    sensors.remove(at: index)
//                }
//            }
//        }
//    }
    
//    public func removeSensor(id:String){
//        for sensor in sensors {
//            if let index = sensors.firstIndex(of: sensor) {
//                if sensor.id == id {
//                    sensors.remove(at: index)
//                }
//            }
//        }
//    }
//    
//    public func getSensor(with sensor: ISensorController) -> ISensorController? {
//        for s in sensors {
//            if s == sensor {
//                return s
//            }
//        }
//        return nil
//    }
    
//    public func getSensors(with type: AnyClass ) -> [LampSensorCore]?{
//        var foundSensors:Array<LampSensorCore> = []
//        for sensor in sensors {
//            if sensor is type(of: type) {
//                foundSensors.append(sensor)
//            }
//        }
//        if foundSensors.count == 0 {
//            return nil
//        }else{
//            return foundSensors
//        }
//    }
    
    public func isExist(with id:String) -> Bool {
        for sensor in sensors {
            if sensor.id == id {
                return true
            }
        }
        return false
    }

    public func getSensor(with id: String) -> ISensorController? {
        for sensor in sensors{
            if sensor.id == id {
                return sensor;
            }
        }
        return nil
    }
    
    public func startAllSensors(){
        for sensor in sensors {
            sensor.start()
        }
    }
    
    public func stopAllSensors(){
        for sensor in sensors {
            sensor.stop()
        }
    }
}

class Utils {
    static let shared = Utils()
    private init() {}
    
    private let timestampKey = "LMPedometerTimestamp"
    
    func getHealthKitLaunchedTimestamp() -> Date {
        let userDefaults = UserDefaults.standard
        if let date = userDefaults.object(forKey: timestampKey) as? Date {
            return date
        }
        let newDate = Date().addingTimeInterval(-10 * 60)
        userDefaults.set(newDate, forKey: timestampKey)
        return newDate
    }
    
    func removeAllSavedDates() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: timestampKey)
    }
}
