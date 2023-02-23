#if canImport(HealthKit)
import Foundation
import HealthKit

public protocol LMHealthKitSensorObserver: AnyObject {
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
    // we are using last sample's start time to fetch next set, to ignore duplicate steps we are caching the last set of records
    var cachedSteps: [UUID]?
    
    public init(_ sensorsToCollect: [String]? = nil) {
        self.sensorsToCollect = sensorsToCollect
        healthStore = HKHealthStore()
    }
    
    public func start() {
        requestAuthorizationForLampHKTypes()
    }
    
    public func stop() {}
    var nutritionTypes: [HKQuantityTypeIdentifier] = [.dietaryFatTotal, .dietaryFatPolyunsaturated, .dietaryFatMonounsaturated, .dietaryFatSaturated, .dietaryCholesterol, .dietarySodium, .dietaryCarbohydrates, .dietaryFiber, .dietarySugar, .dietaryEnergyConsumed, .dietaryProtein, .dietaryVitaminA, .dietaryVitaminB6, .dietaryVitaminB12, .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE, .dietaryVitaminK, .dietaryCalcium, .dietaryIron, .dietaryThiamin, .dietaryRiboflavin, .dietaryNiacin, .dietaryFolate, .dietaryBiotin, .dietaryPantothenicAcid, .dietaryPhosphorus, .dietaryIodine, .dietaryMagnesium, .dietaryZinc, .dietarySelenium, .dietaryCopper, .dietaryManganese, .dietaryChromium, .dietaryMolybdenum, .dietaryChloride, .dietaryPotassium, .dietaryCaffeine, .dietaryWater]
    
    //add all supported healthkit sensors here
    public static let healthkitSensors = [HKCategoryTypeIdentifier.sleepAnalysis.lampIdentifier, HKQuantityTypeIdentifier.heartRate.lampIdentifier, HKQuantityTypeIdentifier.bloodPressureDiastolic.lampIdentifier, HKQuantityTypeIdentifier.respiratoryRate.lampIdentifier, HKQuantityTypeIdentifier.bodyTemperature.lampIdentifier, HKQuantityTypeIdentifier.oxygenSaturation.lampIdentifier, HKQuantityTypeIdentifier.bloodGlucose.lampIdentifier, HKQuantityTypeIdentifier.dietaryIron.lampIdentifier, HKQuantityTypeIdentifier.stepCount.lampIdentifier, SensorType.lamp_segment.lampIdentifier, HKQuantityTypeIdentifier.heartRateVariabilitySDNN.lampIdentifier]
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
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.stepCount.lampIdentifier) == true {
            identifiers.append(.stepCount)
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
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.heartRateVariabilitySDNN.lampIdentifier) == true {
            identifiers.append(.heartRateVariabilitySDNN)
        }
        //identifiers.append(contentsOf: [.bodyTemperature, .basalBodyTemperature, .restingHeartRate, .walkingHeartRateAverage, .heartRateVariabilitySDNN, .oxygenSaturation, .peripheralPerfusionIndex, .bloodGlucose, .numberOfTimesFallen, .electrodermalActivity, .inhalerUsage, .insulinDelivery, .bloodAlcoholContent, .forcedVitalCapacity, .forcedExpiratoryVolume1, .peakExpiratoryFlowRate])
        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.dietaryIron.lampIdentifier) == true {
            identifiers.append(contentsOf: nutritionTypes)//, .uvExposure])
        }
        
        //        identifiers.append(.appleStandTime)
        //        identifiers.append(.environmentalAudioExposure)
        //        identifiers.append(.headphoneAudioExposure)
        
        for identifier in identifiers {
            if let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) {
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
    
    func saveLastRecordedDate(_ date: Date?, fetchedTime: Date, for type: HKSampleType, source: String? = nil) {
        if let endDate = date {
            //Suppose the endDate is greater than 'now' then save 'now'. This is to fix if overlapping data from different sources. example to get sleep duration which reside in between bed time duration
            let dateToSave = min(endDate, fetchedTime) //endDate > fetchedTime ? fetchedTime : endDate
            let userDefaults = UserDefaults.standard
            let key: String
            if let sourceIdentifier = source  {
                key = String(format: "LMHealthKit_%@_timestamp_%@", type.identifier, sourceIdentifier)
                let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
                if type == steptype {
                    setSourceForStep(sourceIdentifier)
                }
            } else {
                key = String(format: "LMHealthKit_%@_timestamp", type.identifier)
            }
            userDefaults.set(dateToSave, forKey: key)
        }
    }
    
    func lastRecordedDate(for type: HKSampleType, source: String? = nil) -> Date {
        let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        if type == steptype && source == nil && stepSourcesCount > 0 {
            return lastRecordedStepDate(for: type, sources: getStepSources()!)
        }
        
        let userDefaults = UserDefaults.standard
        let key: String
        if let sourceIdentifier = source  {
            key = String(format: "LMHealthKit_%@_timestamp_%@", type.identifier, sourceIdentifier)
        } else {
            key = String(format: "LMHealthKit_%@_timestamp", type.identifier)
        }
        
        let date: Date
        if type == steptype {
            if let dateExist = userDefaults.object(forKey: key) as? Date {
                date = dateExist
            } else {
                if source != nil { // for version compatibility
                    let noSourceKey = String(format: "LMHealthKit_%@_timestamp", type.identifier)
                    date = userDefaults.object(forKey: noSourceKey) as? Date ?? Date().pastDay
                    userDefaults.set(date, forKey: key) // set date to key with source
                } else {
                    date = Date().pastDay
                    userDefaults.set(date, forKey: key)
                }
            }
        } else { // default case
            if let dateExist = userDefaults.object(forKey: key) as? Date {
                date = dateExist
            } else {
                date = Date().pastDay
                userDefaults.set(date, forKey: key)
            }
        }
        
        //if saved date is too (6 days) old, then return 1 day old timestamp
        if date < Date().addingTimeInterval(-1 * 6 * 24 * 60 * 60) {
            //if there is a source identifier, and more than 1, then remove it. Currently applied for steps only
            if let sourceIdentifier = source, stepSourcesCount > 0 {
                //cleaning the source
                removeStepSource(sourceIdentifier)
                userDefaults.removeObject(forKey: key)
            }
            return Date().pastDay
        }
        return date
    }
    
    func lastRecordedStepDate(for type: HKSampleType, sources: [String]) -> Date {
        let dates = sources.map({lastRecordedDate(for: type, source: $0)})
        let dateMinSaved = dates.min() ?? Date().pastTenMinutes
        //suppose, at first login, if user used device stpes, and then synced wearable steps, but the wearable enddata might be less than the last saved device's endtime.
        return [Date().pastDay, dateMinSaved].min() ?? Date().pastDay
    }
    
    func setSourceForStep(_ source: String) {
        let userDefaults = UserDefaults.standard
        let key: String = "step_sources"
        if var sources = userDefaults.object(forKey: key) as? [String] {
            if sources.contains(source) == false {
                sources.append(source)
                userDefaults.set(sources, forKey: key)
            }
        } else {
            userDefaults.set([source], forKey: key)
        }
    }
    
    func removeStepSource(_ source: String) {
        let userDefaults = UserDefaults.standard
        let key: String = "step_sources"
        if let sources = userDefaults.object(forKey: key) as? [String] {
            let excludedArray = sources.filter({$0 != source})
            userDefaults.set(excludedArray, forKey: key)
        }
    }
    
    var stepSourcesCount: Int {
        return getStepSources()?.count ?? 0
    }
    
    func getStepSources() -> [String]? {
        return UserDefaults.standard.value(forKey: "step_sources") as? [String]
    }
}

extension Date {
    var pastTenMinutes: Date {
        return addingTimeInterval(-1.0 * 10.0 * 60.0)// past 10 minutes
    }
    var pastDay: Date {
        return addingTimeInterval(-1 * 1 * 24 * 60 * 60)
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
        //        if sensorsToCollect?.contains(HKQuantityTypeIdentifier.stepCount.lampIdentifier) == true {
        //            getStatisticalData(for: HKQuantityTypeIdentifier.stepCount)
        //        }
        let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let quantityTypes = healthQuantityTypes
        for type in quantityTypes {
            if steptype == type {
                fetchStepCounts(type)
            } else {
                healthKitData(for: type, from: lastRecordedDate(for: type))
            }
        }
        //
        
        let categoryTypes = healthCategoryTypes
        for type in categoryTypes {
            healthKitData(for: type, from: lastRecordedDate(for: type))
        }
        
        if healthCharacteristicTypes.count > 0 {
            loadCharachteristicData()
        }
        
        if sensorsToCollect?.contains(SensorType.lamp_segment.lampIdentifier) == true {
            let workoutType = HKWorkoutType.workoutType()
            healthKitData(for: workoutType, from: lastRecordedDate(for: workoutType))
        }
        
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
                data.representation = "\(age)"
                data.value = date.timeIntervalSince1970 * 1000
                arrData.append(data)
            }
            
        } catch let error {
            print("birthdayComponents error = \(error.localizedDescription)")
        }
        do {
            let biologicalSex =       try healthStore.biologicalSex()
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)
            data.value = Double(unwrappedBiologicalSex.rawValue)
            data.representation = unwrappedBiologicalSex.stringValue
            arrData.append(data)
        } catch let error {
            print("biologicalSex error = \(error.localizedDescription)")
        }
        
        do {
            let bloodType =           try healthStore.bloodType()
            let unwrappedBloodType = bloodType.bloodType
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.bloodType)
            data.value = Double(unwrappedBloodType.rawValue)
            data.representation = unwrappedBloodType.stringValue
            arrData.append(data)
        } catch let error {
            print("bloodType error = \(error.localizedDescription)")
        }
        
        do {
            let wheelcharirUse =      try healthStore.wheelchairUse()
            let unwrappedWheelChairUse = wheelcharirUse.wheelchairUse
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.wheelchairUse)
            data.value = Double(unwrappedWheelChairUse.rawValue)
            data.representation = unwrappedWheelChairUse.stringValue
            arrData.append(data)
        } catch let error {
            print("wheelcharirUse error = \(error.localizedDescription)")
        }
        do {
            let skinType =            try healthStore.fitzpatrickSkinType()
            let unWrappedSkinType = skinType.skinType
            
            let data = LMHealthKitCharacteristicData(hkIdentifier: HKCharacteristicTypeIdentifier.fitzpatrickSkinType)
            data.value = Double(unWrappedSkinType.rawValue)
            data.representation = unWrappedSkinType.stringValue
            arrData.append(data)
        } catch let error {
            print("skinType error = \(error.localizedDescription)")
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
    
    //    private func getStatisticalData(for typeIdent: HKQuantityTypeIdentifier) {
    //
    //        guard let quntityType = HKObjectType.quantityType(forIdentifier: typeIdent) else { return }
    //        let loginTime = Utils.shared.getHealthKitLaunchedTimestamp()
    //        let predicate = HKQuery.predicateForSamples(withStart: loginTime, end: Date(), options: .strictEndDate)
    //        // you can combine a cumulative option and seperated by source
    //        let cumulativeQuery = HKStatisticsQuery(quantityType: quntityType, quantitySamplePredicate: predicate, options: ([.cumulativeSum, .separateBySource])) { query, statistics, error in
    //
    //            guard let statistics = statistics else { return }
    //            guard let type = query.objectType as? HKSampleType else { return }
    //            // ... process the results here
    //            var arrData = [LMHealthKitQuantityData]()
    //
    //            if let sources = statistics.sources {
    //
    //                let data = sources.map({ LMHealthKitQuantityData(statistics, source: $0) })
    //                arrData.append(contentsOf: data)
    //
    //            } else {
    //                let data = LMHealthKitQuantityData(statistics, source: nil)
    //                arrData.append(data)
    //            }
    //
    //            if self.healthQuantityTypes.contains(type) {
    //                self.arrQuantityData.append(contentsOf: arrData)
    //            }
    //        }
    //        healthStore.execute(cumulativeQuery)
    //    }
    
    private func healthKitData(for type: HKSampleType, from start: Date) {
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        
        let today = Date()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: today, options: HKQueryOptions.strictStartDate)
        
        let quantityQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (query, sampleObjects, error) in
            
            guard let type = query.objectType as? HKSampleType else { return }
            
            if error != nil {
                self?.observer?.onHKDataFetch(for: type.identifier, error: error)
                return
            }
            if let samples = sampleObjects as? [HKQuantitySample], samples.count > 0 {
                let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
                
                self?.saveQuantityData(samples, for: type)
                if type != steptype {
                    let lastDate = samples.last?.endDate.addingTimeInterval(1)
                    self?.saveLastRecordedDate(lastDate, fetchedTime: today, for: type)
                }
                // for steptype, the date has been saved inside the saveQuantityData()
            } else if let samples = sampleObjects as? [HKCategorySample], samples.count > 0 {
                self?.saveCategoryData(samples, for: type)
                let lastDate = samples.last?.endDate.addingTimeInterval(1)
                self?.saveLastRecordedDate(lastDate, fetchedTime: today, for: type)
            } else if let samples = sampleObjects as? [HKWorkout], samples.count > 0 {
                
                self?.saveWorkoutData(samples, for: type)
                let lastDate = samples.last?.endDate.addingTimeInterval(1)
                self?.saveLastRecordedDate(lastDate, fetchedTime: today, for: type)
            }
        }
        healthStore.execute(quantityQuery)
    }
    
    private func fetchStepCounts(_ stepType: HKSampleType) {
        
        let sourceQuery = HKSourceQuery(sampleType: stepType, samplePredicate: nil) { [weak self]
            (query, sources, error) in
            guard let self = self else { return }
            guard let sources = sources else {
                self.healthKitData(for: stepType, from: self.lastRecordedDate(for: stepType))
                return }
            let today = Date()
            let group = DispatchGroup()
            for source in sources {
                group.enter()
                let savedTimestamp = self.lastRecordedDate(for: stepType, source: source.bundleIdentifier)
                let predicate1 = HKQuery.predicateForSamples(withStart: savedTimestamp, end: today, options: HKQueryOptions.strictStartDate)
                let predicate2 = HKQuery.predicateForObjects(from: source)
                let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate2])
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
                let query = HKSampleQuery(sampleType: stepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, results, error) in
                    if let samples = results as? [HKQuantitySample], samples.count > 0 {
                        self.saveQuantityData(samples, for: stepType)
                    }
                    group.leave()
                }
                self.healthStore.execute(query)
            }
        }
        healthStore.execute(sourceQuery)
    }
    
    private func saveQuantityData(_ samples: [HKQuantitySample], for type: HKSampleType) {
        let steptype = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
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
            data.source = sample.sourceRevision.source.bundleIdentifier
            data.hkDevice = sample.device?.model
            if let meta = sample.metadata {
                data.metadata = meta
            }
            //get last timestamp of this identifier. if the sample.endDate is greater than timestamp then we can add it. And update last saved timestamp.
            if steptype == type {
                if true == cachedSteps?.contains(sample.uuid) {
                    continue
                }
                let savedTimestamp = lastRecordedDate(for: type, source: data.source)
                if sample.startDate > savedTimestamp {
                    arrData.append(data)
                    // we are passing startdate to get if there are multipe entries.
                    self.saveLastRecordedDate(sample.startDate, fetchedTime: Date(), for: type, source: data.source)
                }
            } else { //default case
                arrData.append(data)
            }
        }
        //reset cached data
        if steptype == type {
            cachedSteps = samples.map({ $0.uuid })
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
