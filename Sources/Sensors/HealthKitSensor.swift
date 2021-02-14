#if canImport(HealthKit)
import Foundation
import HealthKit

public protocol LMHealthKitSensorObserver: class {
    func onHKAuthorizationStatusChanged(success: Bool, error: Error?)
    func onHKDataFetch(for type: String, error: Error?)
}

public class LMHealthKitSensor: ISensorController {
    
    // MARK: - VARIABLES
    var sensorsToCollect: [String]?
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
    
    public init(_ sensorsToCollect: [String]? = nil) {
        self.sensorsToCollect = sensorsToCollect
        healthStore = HKHealthStore()
    }
    
    public func start() {
        requestAuthorizationForLampHKTypes()
    }
    
    public func stop() {}
    var nutritionTypes: [HKQuantityTypeIdentifier] = [.dietaryFatTotal, .dietaryFatPolyunsaturated, .dietaryFatMonounsaturated, .dietaryFatSaturated, .dietaryCholesterol, .dietarySodium, .dietaryCarbohydrates, .dietaryFiber, .dietarySugar, .dietaryEnergyConsumed, .dietaryProtein, .dietaryVitaminA, .dietaryVitaminB6, .dietaryVitaminB12, .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE, .dietaryVitaminK, .dietaryCalcium, .dietaryIron, .dietaryThiamin, .dietaryRiboflavin, .dietaryNiacin, .dietaryFolate, .dietaryBiotin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryIodine, .dietaryMagnesium, .dietaryZinc, .dietarySelenium, .dietaryCopper, .dietaryManganese, .dietaryChromium, .dietaryMolybdenum, .dietaryChloride, .dietaryPotassium, .dietaryCaffeine, .dietaryWater]
    //when ever add new data type, then handle the same in fetchHealthKitQuantityData(), extension HKQuantityTypeIdentifier: LampDataKeysProtocol
    public lazy var healthQuantityTypes: [HKSampleType] = {
        
        var quantityTypes = [HKSampleType]()
        var identifiers: [HKQuantityTypeIdentifier] = []// [.heartRate, .bloodPressureDiastolic, .bloodPressureSystolic, .respiratoryRate]
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.heartRate.lampIdentifier) == true {
            identifiers.append(.heartRate)
        }
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.bloodPressureDiastolic.lampIdentifier) == true {
            identifiers.append(.bloodPressureDiastolic)
            identifiers.append(.bloodPressureSystolic)
        }
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.respiratoryRate.lampIdentifier) == true {
            identifiers.append(.respiratoryRate)
        }
        //var identifiers: [HKQuantityTypeIdentifier] = [.heartRate, .bodyMass, .height, .bloodPressureDiastolic, .bloodPressureSystolic, .respiratoryRate, .bodyMassIndex, .bodyFatPercentage, .leanBodyMass, .waistCircumference]
        //identifiers.append(contentsOf: [.stepCount, .distanceWalkingRunning, .distanceCycling, .distanceWheelchair, .basalEnergyBurned, .activeEnergyBurned, .flightsClimbed, .nikeFuel, .appleExerciseTime, .pushCount, .distanceSwimming, .swimmingStrokeCount, .vo2Max, .distanceDownhillSnowSports])
        //identifiers.append(contentsOf: [.bodyTemperature, .oxygenSaturation, .bloodGlucose])
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.bodyTemperature.lampIdentifier) == true {
            identifiers.append(.bodyTemperature)
        }
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.oxygenSaturation.lampIdentifier) == true {
            identifiers.append(.oxygenSaturation)
        }
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.bloodGlucose.lampIdentifier) == true {
            identifiers.append(.bloodGlucose)
        }
        //identifiers.append(contentsOf: [.bodyTemperature, .basalBodyTemperature, .restingHeartRate, .walkingHeartRateAverage, .heartRateVariabilitySDNN, .oxygenSaturation, .peripheralPerfusionIndex, .bloodGlucose, .numberOfTimesFallen, .electrodermalActivity, .inhalerUsage, .insulinDelivery, .bloodAlcoholContent, .forcedVitalCapacity, .forcedExpiratoryVolume1, .peakExpiratoryFlowRate])
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.dietaryIron.lampIdentifier) == true {
            identifiers.append(contentsOf: nutritionTypes)//, .uvExposure])
        }

//        identifiers.append(.appleStandTime)
//        identifiers.append(.environmentalAudioExposure)
//        identifiers.append(.headphoneAudioExposure)

        for identifier in identifiers {
            if let quantityType =   HKQuantityType.quantityType(forIdentifier: identifier) {
                quantityTypes.append(quantityType)
            }
        }
        return quantityTypes
    }()
    
    public lazy var healthCategoryTypes: [HKSampleType] = {
        var arrTypes = [HKSampleType]()
        #if os(iOS)
        var identifiers: [HKCategoryTypeIdentifier] = []//[.sleepAnalysis]
        if sensorsToCollect?.contains(HKCategoryTypeIdentifier.sleepAnalysis.lampIdentifier) == true {
            identifiers.append(.sleepAnalysis)
        }
        //var identifiers: [HKCategoryTypeIdentifier] = [.sleepAnalysis, .appleStandHour, .cervicalMucusQuality, .ovulationTestResult, .menstrualFlow, .intermenstrualBleeding, .sexualActivity, .mindfulSession]
        //identifiers.append(contentsOf: [.highHeartRateEvent, .lowHeartRateEvent, .irregularHeartRhythmEvent, .audioExposureEvent, .toothbrushingEvent])
        for identifier in identifiers {
            if let quantityType = HKCategoryType.categoryType(forIdentifier: identifier) {
                arrTypes.append(quantityType)
            }
        }
        #endif
        return arrTypes
    }()
    
    lazy var healthCharacteristicTypes: [HKObjectType] = {
//        var characteristicTypes = [HKObjectType]()
//        var identifiers: [HKCharacteristicTypeIdentifier] = [HKCharacteristicTypeIdentifier.biologicalSex, HKCharacteristicTypeIdentifier.bloodType, HKCharacteristicTypeIdentifier.dateOfBirth, HKCharacteristicTypeIdentifier.fitzpatrickSkinType, HKCharacteristicTypeIdentifier.wheelchairUse]
//        for identifier in identifiers {
//            if let coreRelationType = HKCorrelationType.characteristicType(forIdentifier: identifier) {
//                characteristicTypes.append(coreRelationType)
//            }
//        }
        return []
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
        print("dataTypes = \(dataTypes)")
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
        if sensorsToCollect?.contains(SensorType.lamp_segment.lampIdentifier) == true {
            let workout = HKWorkoutType.workoutType()
            arrSampleTypes.append(workout)
        }
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
            
            if let sources = statistics.sources {
                
                let data = sources.map({ LMHealthKitQuantityData(statistics, source: $0) })
                arrData.append(contentsOf: data)
                
            } else {
                let data = LMHealthKitQuantityData(statistics, source: nil)
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
        
        if healthCategoryTypes.contains(type) {
            let arrData = samples.map({ LMHealthKitCategoryData($0) })
            arrCategoryData.append(contentsOf: arrData)
        }
    }
    
    private func saveWorkoutData(_ samples: [HKWorkout], for type: HKSampleType) {
        let arrData = samples.map({ LMHealthKitWorkoutData($0) })
        arrWorkoutData.append(contentsOf: arrData)
    }
}
#endif
