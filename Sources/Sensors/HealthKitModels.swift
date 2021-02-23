#if canImport(HealthKit)
import Foundation
import HealthKit

public class LMHealthKitCharacteristicData: LampSensorCoreObject {
    
    public var device: [String: Any]?
    public var startDate: Double?
    public var endDate: Double?
    public var metadata: [String: Any]?
    public var type: String = ""  // eg: HKQuantityTypeIdentifier
    public var value: Double?  // e.g., 60
    public var valueText: String?  // e.g., 60
    public var unit: String? // e.g., count/min
    public var hkIdentifier: HKCharacteristicTypeIdentifier
    public var source: String?
    
    public init(hkIdentifier: HKCharacteristicTypeIdentifier) {
        self.hkIdentifier = hkIdentifier
    }

    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
}

public class LMHealthKitQuantityData: LampSensorCoreObject {
    
    public var device: [String: Any]?
    public var source: String?
    public var startDate: Double?
    public var endDate: Double?
    public var metadata: [String: Any]?
    public var type: String = ""  // eg: HKQuantityTypeIdentifier
    public var value: Double?  // e.g., 60
    public var valueText: String?  // e.g., 60
    public var unit: String? // e.g., count/min
    public var hkIdentifier: HKQuantityTypeIdentifier
    
    public init(hkIdentifier: HKQuantityTypeIdentifier) {
        self.hkIdentifier = hkIdentifier
    }
    
    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
    
    public init(_ statistics: HKStatistics, source: HKSource?) {
        
        let unit = HKUnit.count()
        let typeIdentifier = HKQuantityTypeIdentifier(rawValue: statistics.quantityType.identifier)
        if let hkSource = source {
            self.value = statistics.sumQuantity(for: hkSource)?.doubleValue(for: unit)
        } else {
            self.value = statistics.sumQuantity()?.doubleValue(for: unit)
        }
        self.type = statistics.quantityType.identifier
        self.startDate = statistics.startDate.timeIntervalSince1970 * 1000
        self.endDate = statistics.endDate.timeIntervalSince1970 * 1000
        self.hkIdentifier = typeIdentifier
        self.source = source?.bundleIdentifier
        self.unit      = unit.unitString
    }
}

public class LMHealthKitCategoryData: LampSensorCoreObject {
    
    public var device: [String: Any]?
    public var startDate: Double?
    public var endDate: Double?
    public var metadata: [String: Any]?
    public var type: String = ""  // eg: HKQuantityTypeIdentifier
    public var value: Double?  // e.g., 60
    public var valueText: String?  // e.g., 60
    public var unit: String? // e.g., count/min
    public var hkIdentifier: HKCategoryTypeIdentifier
    public var source: String?
    public var duration: Double?
    
    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
    
    public init(_ sample: HKCategorySample) {
        
        let id = sample.sourceRevision.source.bundleIdentifier
        
        let typeIdentifier = HKCategoryTypeIdentifier(rawValue: sample.categoryType.identifier)
        self.hkIdentifier = typeIdentifier
        // device info
        if let device = sample.device {
            let json = device.toDictionary()
            self.device = json
        }
        self.type = sample.categoryType.identifier
        self.source = id
        
        switch typeIdentifier {
        case .sleepAnalysis:
            self.duration = sample.endDate.timeIntervalSince(sample.startDate) * 1000//to convert to milliseconds
            self.value = Double(sample.value)
            if let sleepAnalysis = HKCategoryValueSleepAnalysis(rawValue: sample.value) {
                self.valueText = sleepAnalysis.stringValue
            }
        case .appleStandHour:
            self.value = Double(sample.value)
            if let standHour = HKCategoryValueAppleStandHour(rawValue: sample.value) {
                self.valueText = standHour.stringValue
            }
        case .cervicalMucusQuality:
            self.value = Double(sample.value)
            if let quality = HKCategoryValueCervicalMucusQuality(rawValue: sample.value) {
                self.valueText = quality.stringValue
            }
        case .ovulationTestResult:
            self.value = Double(sample.value)
            if let obj = HKCategoryValueOvulationTestResult(rawValue: sample.value) {
                self.valueText = obj.stringValue
            }
        case .menstrualFlow:
            self.value = Double(sample.value)
            if let obj = HKCategoryValueMenstrualFlow(rawValue: sample.value) {
                self.valueText = obj.stringValue
            }
        default:
            self.value = Double(sample.value)
        }
        
        if #available(iOS 13.0, *) {
            if typeIdentifier == .audioExposureEvent {
                self.value = Double(sample.value)
                if let obj = HKCategoryValueAudioExposureEvent(rawValue: sample.value) {
                    self.valueText = obj.stringValue
                }
            }
        }
        
        self.startDate = sample.startDate.timeIntervalSince1970 * 1000
        self.endDate   = sample.endDate.timeIntervalSince1970 * 1000

        if let meta = sample.metadata {
            self.metadata = meta
        }
    }
}

public class LMHealthKitWorkoutData: LampSensorCoreObject {
    
    public var device: [String: Any]?
    public var startDate: Double?
    public var endDate: Double?
    public var metadata: [String: Any]?
    public var type: String = ""  // eg: HKQuantityTypeIdentifier
    public var duration: Double?  // e.g., 60
    public var valueText: String?  // e.g., 60
    public var unit: String? // e.g., count/min
    public var source: String?
    
    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
    
    public init(_ sample: HKWorkout) {
        
        if let device = sample.device{
            let json = device.toDictionary()
            self.device = json
        }
        self.type = sample.workoutActivityType.stringType
        self.duration = sample.duration
        self.startDate = sample.startDate.timeIntervalSince1970 * 1000
        self.endDate   = sample.endDate.timeIntervalSince1970 * 1000
        self.source = sample.sourceRevision.source.bundleIdentifier
        if let meta = sample.metadata {
            self.metadata = meta
        }
    }
}
#endif
