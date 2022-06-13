//
//  SensorLoader.swift
//  mindlamp
//
//  Created by ZCO Engineer on 06/05/22.
//
#if !os(watchOS)
import Foundation
import SensorKit

public protocol SensorKitObserver: AnyObject {
    func onSensorFetch(_ fetchedData: SensorKitEvent)
    func onSensorKitError(_ errType: Error)
}

public class SRSensorLoader {
    
    struct Config {
        var intervalMilliSeconds: Double //in milliseconds
        init(frequency: Double) {
            self.intervalMilliSeconds = frequency > 0 ? (1.0 / frequency * 1000) : 1000
        }
    }
    
    private var allConfiguredSensors: [SRSensor]?
    private lazy var delegate: SRSensorDelegate = { SRSensorDelegate() }()
    public static var allSensors: [SRSensor] {
        let sensors: [SRSensor] = [.deviceUsageReport, .ambientLightSensor, .phoneUsageReport, .messagesUsageReport, .visits, .onWristState]
        //.keyboardMetrics,
//        if #available(iOS 15.0, *) {
//            sensors.append(.siriSpeechMetrics)
//            sensors.append(.telephonySpeechMetrics)
//        }
        return sensors
    }
    
    public static var allLampIdentifiers: [String] {
        return allSensors.map {$0.lampIdentifier}
    }
    
    lazy var allSensorReaders: [SRSensorReader]? = { allConfiguredSensors?.map { createSensorReader($0) } }()
    
    public var observer: SensorKitObserver? {
        didSet {
            delegate.callbackdelegate = observer
        }
    }
    
    public init(_ sensorsToCollect: [String], frquencySettings: [String: Double]) {
        var frequncyDict = frquencySettings
        allConfiguredSensors = SRSensor.getSRSensorsFrom(identifiers: sensorsToCollect)
        
        //only for ambient_light set default-frequency = 1 (1 record per second)
        if nil == frquencySettings[SRSensor.ambientLightSensor.lampIdentifier] {
            frequncyDict[SRSensor.ambientLightSensor.lampIdentifier] = 1.0
        }
        delegate.frequencySettings = frequncyDict.mapValues({Config(frequency: $0)})
    }
    public func removeSavedTimestamps() {
        let userDefaults = UserDefaults.standard
        SRSensorLoader.allSensors.forEach { (sensor) in
            let key = sensor.dateAccessKey
            userDefaults.removeObject(forKey: key)
        }
    }
    public func fetchData() {
        
        allSensorReaders?.filter { $0.authorizationStatus == .authorized }.forEach({ reader in
            
            let fromDate = SRSensor.startDateOf(sensor: reader.sensor)
            let toDate = Date()

            let fromAbsTime = NSDate(timeIntervalSince1970: fromDate.timeIntervalSince1970).srAbsoluteTime
            let toAbsTime = NSDate(timeIntervalSince1970: toDate.timeIntervalSince1970).srAbsoluteTime
            
            let request = SRFetchRequest()
            request.from = fromAbsTime
            request.to = toAbsTime
            
            reader.fetch(request)
        })
    }
    
    // Helper functions
    private func createSensorReader(_ sensor: SRSensor) -> SRSensorReader {
        let sensor = SRSensorReader(sensor: sensor)
        sensor.delegate = delegate
        return sensor
    }
    
    // Displays the authorization approval prompt.
    private func requestAuthorization() {
        
        guard let sensorsToAuthrize = (allSensorReaders?.filter { $0.authorizationStatus != .authorized })?.map({ $0.sensor }), sensorsToAuthrize.count > 0 else {
            return
        }
        let sensorsToRequest = Set(sensorsToAuthrize)
        
        if sensorsToRequest.count > 0 {
            SRSensorReader.requestAuthorization(sensors: sensorsToRequest) { (error: Error?) in
                if let error = error {
                    print("Sensor authorization failed due to: \(error.localizedDescription)")
                    self.observer?.onSensorKitError(error)
                } else {
                    print("""
                        User dismissed the authorization prompt.
                        Awaiting authorization status changes.
                    """)
                }
            }
        }
    }
}

extension SRSensorLoader: ISensorController {
    
    public func start() {
        
        allSensorReaders?.filter { $0.authorizationStatus == .authorized }.forEach {$0.startRecording()}
        requestAuthorization()

    }
    
    public func stop() {
        
        allSensorReaders?.filter { $0.authorizationStatus == .authorized }.forEach {$0.stopRecording()}

    }
}

#endif
