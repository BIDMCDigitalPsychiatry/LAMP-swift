#if canImport(HealthKit)
import Foundation
import HealthKit

import Foundation

extension HKWorkoutActivityType {
    
    var stringType: String {
        switch self {
        case .running:
            return "running"
        case .golf:
            return "golf"
        case .hiking:
            return "hiking"
        case .dance:
            return "dance"
        case .yoga:
            return "yoga"
        case .soccer:
            return "soccer"
        case .rowing:
            return "rowing"
        case .tennis:
            return "tennis"
        case .stairs:
            return "stairs"
        case .bowling:
            return "bowling"
        case .cycling:
            return "cycling"
        case .fishing:
            return "fishing"
        case .walking:
            return "walking"
        case .pilates:
            return "pilates"
        case .baseball:
            return "baseball"
        case .badminton:
            return "badminton"
        case .gymnastics:
            return "gymnastics"
        case .swimming:
            return "swimming"
        case .basketball:
            return "basketball"
        case .snowSports:
            return "snow_sports"
        case .handCycling:
            return "hand_cycling"
        case .tableTennis:
            return "table_tennis"
        case .coreTraining:
            return "core_training"
        case .snowboarding:
            return "snowboarding"
        case .stepTraining:
            return "step_training"
        case .other:
            return "other"
        default:
            return "---"
        }
    }
}

extension HKDevice {
    public func toDictionary() -> [String: Any] {
        // name:Apple Watch, manufacturer:Apple, model:Watch, hardware:Watch2,4, software:5.1.1
        var dict = [String: Any]()
        if let uwName = name { dict["name"] = uwName }
        if let uwManufacturer = manufacturer { dict["manufacturer"] = uwManufacturer }
        if let uwModel = model { dict["model"] = uwModel }
        if let uwHardware = hardwareVersion { dict["hardware"] = uwHardware }
        if let uwSoftware = softwareVersion { dict["software"] = uwSoftware }
        return dict
    }
}

extension HKCategoryValueSleepAnalysis: TextPresentation {
    
    var stringValue: String? {
        switch self {
        case .inBed:
            return "in_bed"
        case .asleep:
            return "in_sleep"
        case .awake:
            return "in_awake"
        @unknown default:
            return nil
        }
    }
}

@available(iOS 13.0, *)
extension HKCategoryValueAudioExposureEvent: TextPresentation {
    var stringValue: String? {
        switch self {
        case .loudEnvironment:
            return "loud_environment"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueMenstrualFlow: TextPresentation {
    var stringValue: String? {
        switch self {
        case .unspecified:
            return "unspecified"
        case .light:
            return "light"
        case .medium:
            return "medium"
        case .heavy:
            return "heavy"
        case .none:
            return "none"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueOvulationTestResult: TextPresentation {
    var stringValue: String? {
        switch self {
            
        case .negative:
            return "negative"
        case .luteinizingHormoneSurge:
            return "luteinizing_hormone_surge"
        case .indeterminate:
            return "indeterminate"
        case .estrogenSurge:
            return "estrogen_surge"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueCervicalMucusQuality: TextPresentation {
    var stringValue: String? {
        switch self {
        case .dry:
            return "dry"
        case .sticky:
            return "sticky"
        case .creamy:
            return "creamy"
        case .watery:
            return "watery"
        case .eggWhite:
            return "egg_white"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueAppleStandHour: TextPresentation {
    var stringValue: String? {
        switch self {
        case .stood:
            return "stood"
        case .idle:
            return "idle"
        @unknown default:
            return nil
        }
    }
}

extension HKBiologicalSex: TextPresentation {
    var stringValue: String? {
        switch self {
            
        case .notSet:
            return "not_set"
        case .female:
            return "female"
        case .male:
            return "male"
        case .other:
            return "other"
        @unknown default:
            return nil
        }
    }
}

extension HKBloodType: TextPresentation {
    var stringValue: String? {
        switch self {
            
            
        case .notSet:
            return "not_set"
        case .aPositive:
            return "A Positive"
        case .aNegative:
            return "A Negative"
        case .bPositive:
            return "B Positive"
        case .bNegative:
            return "B Negative"
        case .abPositive:
            return "AB Positive"
        case .abNegative:
            return "AB Negative"
        case .oPositive:
            return "O Positive"
        case .oNegative:
            return "O Negative"
        @unknown default:
            return nil
        }
    }
}

extension HKWheelchairUse: TextPresentation {
    
    var stringValue: String? {
        switch self {
            
        case .notSet:
            return "not_set"
        case .no:
            return "no"
        case .yes:
            return "yes"
        @unknown default:
            return nil
        }
    }
}

extension HKFitzpatrickSkinType: TextPresentation {
    
    var stringValue: String? {
        switch self {
        case .notSet:
            return "Not Set"
        case .I:
            return "Pale white skin that always burns easily in the sun and never tans."
        case .II:
            return "White skin that burns easily and tans minimally."
        case .III:
            return "White to light brown skin that burns moderately and tans uniformly."
        case .IV:
            return "Beige-olive, lightly tanned skin that burns minimally and tans moderately."
        case .V:
            return "Brown skin that rarely burns and tans profusely."
        case .VI:
            return "Dark brown to black skin that never burns and tans profusely."
        @unknown default:
            return nil
        }
    }
}
#endif
