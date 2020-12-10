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
    
    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
    
    public init(hkIdentifier: HKCategoryTypeIdentifier) {
        self.hkIdentifier = hkIdentifier
    }
}

public class LMHealthKitWorkoutData: LampSensorCoreObject {
    
    public var device: [String: Any]?
    public var startDate: Double?
    public var endDate: Double?
    public var metadata: [String: Any]?
    public var type: String = ""  // eg: HKQuantityTypeIdentifier
    public var value: Double?  // e.g., 60
    public var valueText: String?  // e.g., 60
    public var unit: String? // e.g., count/min

    public var timestamp: Double {
        return endDate ?? Double(timestampInternal)
    }
}

public protocol LMHealthKitSensorObserver: class {
    func onHKAuthorizationStatusChanged(success: Bool, error: Error?)
    func onHKDataFetch(for type: String, error: Error?)
}

public class LMHealthKitSensor: ISensorController {
    
    // MARK: - VARIABLES
    
    public weak var observer: LMHealthKitSensorObserver?
    public var healthStore : HKHealthStore
    //public var fetchLimit = 100
    
    //HKQuantityData
    private var arrQuantityData = [LMHealthKitQuantityData]()
    //HKCategoryData
    private var arrCategoryData = [LMHealthKitCategoryData]()
    //HK Characteristic data
    private var arrCharacteristicData = [LMHealthKitCharacteristicData]()
    //HKWorkoutData
    private var arrWorkoutData = [LMHealthKitWorkoutData]()
    
    public init() {
        healthStore = HKHealthStore()
        //super.init()
    }
    
    public func start() {
        requestAuthorizationForLampHKTypes()
    }
    
    public func stop() {}
    //when ever add new data type, then handle the same in fetchHealthKitQuantityData(), extension HKQuantityTypeIdentifier: LampDataKeysProtocol
    public lazy var healthQuantityTypes: [HKSampleType] = {
        
        var quantityTypes = [HKSampleType]()
        var identifiers: [HKQuantityTypeIdentifier] = [.heartRate, .bodyMass, .height, .bloodPressureDiastolic, .bloodPressureSystolic, .respiratoryRate, .bodyMassIndex, .bodyFatPercentage, .leanBodyMass, .waistCircumference]
        identifiers.append(contentsOf: [.stepCount, .distanceWalkingRunning, .distanceCycling, .distanceWheelchair, .basalEnergyBurned, .activeEnergyBurned, .flightsClimbed, .nikeFuel, .appleExerciseTime, .pushCount, .distanceSwimming, .swimmingStrokeCount, .vo2Max, .distanceDownhillSnowSports])
        identifiers.append(contentsOf: [.bodyTemperature, .basalBodyTemperature, .restingHeartRate, .walkingHeartRateAverage, .heartRateVariabilitySDNN, .oxygenSaturation, .peripheralPerfusionIndex, .bloodGlucose, .numberOfTimesFallen, .electrodermalActivity, .inhalerUsage, .insulinDelivery, .bloodAlcoholContent, .forcedVitalCapacity, .forcedExpiratoryVolume1, .peakExpiratoryFlowRate])
        identifiers.append(contentsOf: [.dietaryFatTotal, .dietaryFatPolyunsaturated, .dietaryFatMonounsaturated, .dietaryFatSaturated, .dietaryCholesterol, .dietarySodium, .dietaryCarbohydrates, .dietaryFiber, .dietarySugar, .dietaryEnergyConsumed, .dietaryProtein, .dietaryVitaminA, .dietaryVitaminB6, .dietaryVitaminB12, .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE, .dietaryVitaminK, .dietaryCalcium, .dietaryIron, .dietaryThiamin, .dietaryRiboflavin, .dietaryNiacin, .dietaryFolate, .dietaryBiotin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryIodine, .dietaryMagnesium, .dietaryZinc, .dietarySelenium, .dietaryCopper, .dietaryManganese, .dietaryChromium, .dietaryMolybdenum, .dietaryChloride, .dietaryPotassium, .dietaryCaffeine, .dietaryWater, .uvExposure])
        if #available(iOS 13.0, *) {
            identifiers.append(.appleStandTime)
            identifiers.append(.environmentalAudioExposure)
            identifiers.append(.headphoneAudioExposure)
            
        } else {
            // Fallback on earlier versions
        }
        for identifier in identifiers {
            if let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) {
                quantityTypes.append(quantityType)
            }
        }
        return quantityTypes
    }()
    
    public lazy var healthCategoryTypes: [HKSampleType] = {
        var arrTypes = [HKSampleType]()
        var identifiers: [HKCategoryTypeIdentifier] = [.sleepAnalysis, .appleStandHour, .cervicalMucusQuality, .ovulationTestResult, .menstrualFlow, .intermenstrualBleeding, .sexualActivity, .mindfulSession]
        if #available(iOS 13.0, *) {
            identifiers.append(contentsOf: [.highHeartRateEvent, .lowHeartRateEvent, .irregularHeartRhythmEvent, .audioExposureEvent, .toothbrushingEvent])
        }
        for identifier in identifiers {
            if let quantityType = HKCategoryType.categoryType(forIdentifier: identifier) {
                arrTypes.append(quantityType)
            }
        }
        return arrTypes
    }()
    
    lazy var healthCharacteristicTypes: [HKObjectType] = {
        var characteristicTypes = [HKObjectType]()
        var identifiers: [HKCharacteristicTypeIdentifier] = [HKCharacteristicTypeIdentifier.biologicalSex, HKCharacteristicTypeIdentifier.bloodType, HKCharacteristicTypeIdentifier.dateOfBirth, HKCharacteristicTypeIdentifier.fitzpatrickSkinType, HKCharacteristicTypeIdentifier.wheelchairUse]
        for identifier in identifiers {
            if let coreRelationType = HKCorrelationType.characteristicType(forIdentifier: identifier) {
                characteristicTypes.append(coreRelationType)
            }
        }
        return characteristicTypes
    }()
    
    public func clearDataArrays() {
        arrQuantityData.removeAll()
        arrCategoryData.removeAll()
        arrWorkoutData.removeAll()
        arrCharacteristicData.removeAll()
    }
    
    public func removeSavedTimestamps() {
        let userDefaults = UserDefaults.standard
        healthQuantityTypes.forEach { (type) in
            let key = String(format: "LMHealthKit_%@_timestamp", type.identifier)
            userDefaults.removeObject(forKey: key)
        }
        Utils.shared.removeAllSavedDates()
    }
}

private extension LMHealthKitSensor {
    
    func requestAuthorizationForLampHKTypes() {
        
        guard HKHealthStore.isHealthDataAvailable() == true else {
            return
        }
        
        let dataTypes = Set(lampHealthKitTypes())
        healthStore.requestAuthorization(toShare: nil, read: dataTypes) { [weak self] (success, error) -> Void in
            if let observer = self?.observer {
                observer.onHKAuthorizationStatusChanged(success: success, error: error)
            }
        }
    }
    
    func lampHealthKitTypes() -> [HKObjectType] {
        var arrSampleTypes = [HKObjectType]()
        
        arrSampleTypes.append(contentsOf: healthQuantityTypes)
        arrSampleTypes.append(contentsOf: healthCategoryTypes)
        arrSampleTypes.append(contentsOf: healthCharacteristicTypes)
        let workout = HKWorkoutType.workoutType()
        arrSampleTypes.append(workout)
        
        return arrSampleTypes
    }
    
    func saveLastRecordedDate(_ date: Date?, for type: HKSampleType) {
        if let dateToSave = date {
            let userDefaults = UserDefaults.standard
            let key = String(format: "LMHealthKit_%@_timestamp", type.identifier)
            userDefaults.set(dateToSave, forKey: key)
        }
    }
    
    func lastRecordedDate(for type: HKSampleType) -> Date {
        let userDefaults = UserDefaults.standard
        let key = String(format: "LMHealthKit_%@_timestamp", type.identifier)
        let date = userDefaults.object(forKey: key) as? Date ?? Date().addingTimeInterval(-1.0 * 10.0 * 60.0)// past 10 minutes
        return date
    }
}

extension LMHealthKitSensor {
    
    public func latestQuantityData() -> [LMHealthKitQuantityData]? {
        return arrQuantityData
    }
    
    public func latestCategoryData() -> [LMHealthKitCategoryData]? {
        return arrCategoryData
    }
    
    public func latestCharacteristicData() -> [LMHealthKitCharacteristicData]? {
        return arrCharacteristicData
    }
    
    public func latestWorkoutData() -> [LMHealthKitWorkoutData]? {
        return arrWorkoutData
    }
    
    public func fetchHealthData() {
        //clearDataArrays()
        //stepcount
        getStatisticalData(for: HKQuantityTypeIdentifier.stepCount)
        
        let quantityTypes = healthQuantityTypes
        for type in quantityTypes {
            healthKitData(for: type, from: lastRecordedDate(for: type))
        }
        //
        
        let categoryTypes = healthCategoryTypes
        for type in categoryTypes {
            healthKitData(for: type, from: lastRecordedDate(for: type))
        }
        
        loadCharachteristicData()
        
        let workoutType = HKWorkoutType.workoutType()
        healthKitData(for: workoutType, from: lastRecordedDate(for: workoutType))
    }
    
    func loadCharachteristicData() {
        
        var arrData = [LMHealthKitCharacteristicData]()
        
        do {
            //1. This method throws an error if these data are not available.
            let birthdayComponents =  try healthStore.dateOfBirthComponents()
            
            //2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                              from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
            
            if let date = Calendar.current.date(from: birthdayComponents) {
                let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)
                data.valueText = "\(age)"
                data.value = date.timeIntervalSince1970 * 1000
                arrData.append(data)
            }
            
        } catch let error {
            print("error = \(error.localizedDescription)")
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_characteristicType_fetch_error + error.localizedDescription)
        }
        do {
            let biologicalSex =       try healthStore.biologicalSex()
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)
            data.value = Double(unwrappedBiologicalSex.rawValue)
            data.valueText = unwrappedBiologicalSex.stringValue
            arrData.append(data)
        } catch let error {
            print("error = \(error.localizedDescription)")
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_characteristicType_fetch_error + error.localizedDescription)
        }
        
        do {
            let bloodType =           try healthStore.bloodType()
            let unwrappedBloodType = bloodType.bloodType
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.bloodType)
            data.value = Double(unwrappedBloodType.rawValue)
            data.valueText = unwrappedBloodType.stringValue
            arrData.append(data)
        } catch let error {
            print("error = \(error.localizedDescription)")
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_characteristicType_fetch_error + error.localizedDescription)
        }
        
        do {
            let wheelcharirUse =      try healthStore.wheelchairUse()
            let unwrappedWheelChairUse = wheelcharirUse.wheelchairUse
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.wheelchairUse)
            data.value = Double(unwrappedWheelChairUse.rawValue)
            data.valueText = unwrappedWheelChairUse.stringValue
            arrData.append(data)
        } catch let error {
            print("error = \(error.localizedDescription)")
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_characteristicType_fetch_error + error.localizedDescription)
        }
        do {
            let skinType =            try healthStore.fitzpatrickSkinType()
            let unWrappedSkinType = skinType.skinType
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.fitzpatrickSkinType)
            data.value = Double(unWrappedSkinType.rawValue)
            data.valueText = unWrappedSkinType.stringValue
            arrData.append(data)
        } catch let error {
            print("error = \(error.localizedDescription)")
            //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_characteristicType_fetch_error + error.localizedDescription)
        }
        arrCharacteristicData.append(contentsOf: arrData)
    }
    
    //    private func unit(for type: HKSampleType) -> HKUnit {
    
    //        switch type.identifier {
    //        case HKIdentifiers.bloodpressure_systolic.rawValue, HKIdentifiers.bloodpressure_diastolic.rawValue:
    //            return .millimeterOfMercury()
    //        case HKIdentifiers.heart_rate.rawValue, HKIdentifiers.respiratory_rate.rawValue:
    //            return HKUnit.count().unitDivided(by: .minute())
    //        case HKIdentifiers.height.rawValue:
    //            return .meterUnit(with: .centi)
    //        case HKIdentifiers.weight.rawValue:
    //            return .gramUnit(with: .kilo)
    //        default:
    //            return HKUnit.count()
    //        }
    //    }
    
    private func getStatisticalData(for typeIdent: HKQuantityTypeIdentifier) {
        
        guard let quntityType = HKObjectType.quantityType(forIdentifier: typeIdent) else { return }
        let loginTime = Utils.shared.getHealthKitLaunchedTimestamp()
        let predicate = HKQuery.predicateForSamples(withStart: loginTime, end: Date(), options: .strictEndDate)
        // you can combine a cumulative option and seperated by source
        let cumulativeQuery = HKStatisticsQuery(quantityType: quntityType, quantitySamplePredicate: predicate, options: ([.cumulativeSum, .separateBySource])) { query, statistics, error in
            
            guard let statistics = statistics else { return }
            guard let type = query.objectType as? HKSampleType else { return }
            // ... process the results here
            var arrData = [LMHealthKitQuantityData]()
            let typeIdentifier = HKQuantityTypeIdentifier(rawValue: statistics.quantityType.identifier)
            
            let unit = HKUnit.count()
            if let sources = statistics.sources {
                
                for source in sources {
                    let count = statistics.sumQuantity(for: source)?.doubleValue(for: unit)
                    
                    let data = LMHealthKitQuantityData(hkIdentifier: typeIdentifier)
                    data.type      = statistics.quantityType.identifier
                    data.startDate = statistics.startDate.timeIntervalSince1970 * 1000
                    data.endDate   = statistics.endDate.timeIntervalSince1970 * 1000
                    data.hkIdentifier = typeIdentifier
                    
                    data.source = source.bundleIdentifier
                    
                    data.value     = count
                    data.unit      = unit.unitString
                    
                    arrData.append(data)
                }
                
            } else {
                let count = statistics.sumQuantity()?.doubleValue(for: unit)
                
                let data = LMHealthKitQuantityData(hkIdentifier: typeIdentifier)
                data.type      = statistics.quantityType.identifier
                data.startDate = statistics.startDate.timeIntervalSince1970 * 1000
                data.endDate   = statistics.endDate.timeIntervalSince1970 * 1000
                data.hkIdentifier = typeIdentifier
                
                data.value     = count
                data.unit      = unit.unitString
                
                arrData.append(data)
            }
            
            if self.healthQuantityTypes.contains(type) {
                self.arrQuantityData.append(contentsOf: arrData)
            }
        }
        healthStore.execute(cumulativeQuery)
    }
    
    private func healthKitData(for type: HKSampleType, from start: Date) {

        let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        if type == steptype {
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        
        let today = Date()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: today, options: HKQueryOptions.strictStartDate)
        
        let quantityQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (query, sampleObjects, error) in
            
            guard let type = query.objectType as? HKSampleType else { return }
            
            if error != nil {
                self?.observer?.onHKDataFetch(for: type.identifier, error: error)
                return
            }
            if let samples = sampleObjects as? [HKQuantitySample] {
                
                self?.saveQuantityData(samples, for: type)
                let lastDate = samples.last?.endDate.addingTimeInterval(1)
                self?.saveLastRecordedDate(lastDate, for: type)
            } else if let samples = sampleObjects as? [HKCategorySample] {
                
                self?.saveCategoryData(samples, for: type)
                let lastDate = samples.last?.endDate.addingTimeInterval(1)
                self?.saveLastRecordedDate(lastDate, for: type)
            } else if let samples = sampleObjects as? [HKWorkout] {
                
                self?.saveWorkoutData(samples, for: type)
                let lastDate = samples.last?.endDate.addingTimeInterval(1)
                self?.saveLastRecordedDate(lastDate, for: type)
            }
        }
        healthStore.execute(quantityQuery)
    }
    
    
    private func saveQuantityData(_ samples: [HKQuantitySample], for type: HKSampleType) {
        
        var arrData = [LMHealthKitQuantityData]()
        for sample in samples {
            let typeIdentifier = HKQuantityTypeIdentifier(rawValue: sample.quantityType.identifier)
            let data = LMHealthKitQuantityData(hkIdentifier: typeIdentifier)
            // device info
            if let device = sample.device {
                let json = device.toDictionary()
                data.device = json
            }
            let queryGroup = DispatchGroup()
            queryGroup.enter()
            var errorUnit: Error?
            healthStore.preferredUnits(for: [sample.quantityType]) { (dict, err) in
                if let unit = dict[sample.quantityType] {
                    data.value     = sample.quantity.doubleValue(for: unit)
                    data.unit      = unit.unitString
                } else {
                    errorUnit = err
                }
                queryGroup.leave()
            }
            if nil != errorUnit {
                //LMLogsManager.shared.addLogs(level: .warning, logs: Logs.Messages.hk_data_fetch_uniterror + err.localizedDescription)
                continue
            }
            
            data.type      = sample.quantityType.identifier
            data.startDate = sample.startDate.timeIntervalSince1970 * 1000
            data.endDate   = sample.endDate.timeIntervalSince1970 * 1000
            data.hkIdentifier = typeIdentifier
            if let meta = sample.metadata {
                data.metadata = meta
            }
            arrData.append(data)
        }
        if healthQuantityTypes.contains(type) {
            arrQuantityData.append(contentsOf: arrData)
        }
    }
    
    private func saveCategoryData(_ samples: [HKCategorySample], for type: HKSampleType) {
        
        var arrData = [LMHealthKitCategoryData]()
        for sample in samples {
            let typeIdentifier = HKCategoryTypeIdentifier(rawValue: sample.categoryType.identifier)
            let data = LMHealthKitCategoryData(hkIdentifier: typeIdentifier)
            // device info
            if let device = sample.device {
                let json = device.toDictionary()
                data.device = json
            }
            data.type = sample.categoryType.identifier
            
            switch typeIdentifier {
            case .sleepAnalysis:
                data.value = Double(sample.value)
                if let sleepAnalysis = HKCategoryValueSleepAnalysis(rawValue: sample.value) {
                    data.valueText = sleepAnalysis.stringValue
                }
            case .appleStandHour:
                data.value = Double(sample.value)
                if let standHour = HKCategoryValueAppleStandHour(rawValue: sample.value) {
                    data.valueText = standHour.stringValue
                }
            case .cervicalMucusQuality:
                data.value = Double(sample.value)
                if let quality = HKCategoryValueCervicalMucusQuality(rawValue: sample.value) {
                    data.valueText = quality.stringValue
                }
            case .ovulationTestResult:
                data.value = Double(sample.value)
                if let obj = HKCategoryValueOvulationTestResult(rawValue: sample.value) {
                    data.valueText = obj.stringValue
                }
            case .menstrualFlow:
                data.value = Double(sample.value)
                if let obj = HKCategoryValueMenstrualFlow(rawValue: sample.value) {
                    data.valueText = obj.stringValue
                }
            default:
                data.value = Double(sample.value)
            }
            
            if #available(iOS 13.0, *) {
                if typeIdentifier == .audioExposureEvent {
                    data.value = Double(sample.value)
                    if let obj = HKCategoryValueAudioExposureEvent(rawValue: sample.value) {
                        data.valueText = obj.stringValue
                    }
                }
            }
            
            data.startDate = sample.startDate.timeIntervalSince1970 * 1000
            data.endDate   = sample.endDate.timeIntervalSince1970 * 1000
            data.hkIdentifier = typeIdentifier
            if let meta = sample.metadata {
                data.metadata = meta
            }
            arrData.append(data)
        }
        if healthCategoryTypes.contains(type) {
            arrCategoryData.append(contentsOf: arrData)
        }
    }
    
    private func saveWorkoutData(_ samples: [HKWorkout], for type: HKSampleType) {
        var arrData = [LMHealthKitWorkoutData]()
        for sample in samples {
            
            let data = LMHealthKitWorkoutData()
            // device info
            if let device = sample.device{
                let json = device.toDictionary()
                data.device = json
            }
            data.type = sample.workoutActivityType.stringType
            data.value = sample.duration
            data.startDate = sample.startDate.timeIntervalSince1970 * 1000
            data.endDate   = sample.endDate.timeIntervalSince1970 * 1000
            if let meta = sample.metadata {
                data.metadata = meta
            }
            arrData.append(data)
        }
        arrWorkoutData.append(contentsOf: arrData)
    }
}

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
            return "In Bed"
        case .asleep:
            return "In Sleep"
        case .awake:
            return "In Awake"
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
            return "Loud Environment"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueMenstrualFlow: TextPresentation {
    var stringValue: String? {
        switch self {
        case .unspecified:
            return "Unspecified"
        case .light:
            return "Light"
        case .medium:
            return "Medium"
        case .heavy:
            return "Heavy"
        case .none:
            return "None"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueOvulationTestResult: TextPresentation {
    var stringValue: String? {
        switch self {
            
        case .negative:
            return "Negative"
        case .luteinizingHormoneSurge:
            return "Luteinizing Hormone Surge"
        case .indeterminate:
            return "Indeterminate"
        case .estrogenSurge:
            return "Estrogen Surge"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueCervicalMucusQuality: TextPresentation {
    var stringValue: String? {
        switch self {
        case .dry:
            return "Dry"
        case .sticky:
            return "Sticky"
        case .creamy:
            return "Creamy"
        case .watery:
            return "Watery"
        case .eggWhite:
            return "Egg White"
        @unknown default:
            return nil
        }
    }
}

extension HKCategoryValueAppleStandHour: TextPresentation {
    var stringValue: String? {
        switch self {
        case .stood:
            return "Stood"
        case .idle:
            return "Idle"
        @unknown default:
            return nil
        }
    }
}

extension HKBiologicalSex: TextPresentation {
    var stringValue: String? {
        switch self {
            
        case .notSet:
            return "Not Set"
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
            return "Not Set"
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
            return "Not Set"
        case .no:
            return "No"
        case .yes:
            return "Yes"
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
