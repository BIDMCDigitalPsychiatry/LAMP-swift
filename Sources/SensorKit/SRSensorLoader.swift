//
//  SensorLoader.swift
//  mindlamp
//
//  Created by Jijo Pulikkottil on 06/05/22.
//
#if !os(watchOS)
import Foundation
import SensorKit

public protocol SensorKitObserver: AnyObject {
    func onSensorFetch(for type: String, model: SRSensorModel)
}

public class SRSensorLoader {
    
    private var allSensors: [SRSensor] = [.ambientLightSensor, .deviceUsageReport]
    private lazy var delegate: SRSensorDelegate = { SRSensorDelegate() }()
    
    lazy var allSensorReaders: [SRSensorReader] = { allSensors.map { createSensorReader($0) } }()
    
    func fetchData(from: Date, to: Date) {
        
        let fromTime = NSDate(timeIntervalSince1970: from.timeIntervalSince1970).srAbsoluteTime
        let toTime = NSDate(timeIntervalSince1970: to.timeIntervalSince1970).srAbsoluteTime
        
        let request = SRFetchRequest()
        request.from = fromTime
        request.to = toTime
        
        allSensorReaders.forEach { $0.fetch(request) }

    }
    
    // Helper functions
    private func createSensorReader(_ sensor: SRSensor) -> SRSensorReader {
        let sensor = SRSensorReader(sensor: sensor)
        sensor.delegate = delegate
        return sensor
    }
    
    // Displays the authorization approval prompt.
    private func requestAuthorization() {
        
        let sensorsToRequest = Set(allSensorReaders.filter { $0.authorizationStatus != .authorized }.map{ $0.sensor })
        
        if sensorsToRequest.count > 0 {
            SRSensorReader.requestAuthorization(sensors: sensorsToRequest) { (error: Error?) in
                if let error = error {
                    fatalError("Sensor authorization failed due to: \(error)")
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
        
        allSensorReaders.filter { $0.authorizationStatus == .authorized }.forEach {$0.startRecording()}
        
        requestAuthorization()
    }
    
    public func stop() {
        
        allSensorReaders.filter { $0.authorizationStatus == .authorized }.forEach {$0.stopRecording()}

    }
}

#endif
