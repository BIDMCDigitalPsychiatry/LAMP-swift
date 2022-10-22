//
//  File.swift
//  
//
//  Created by ZCO Engineer on 12/05/22.
//
#if !os(watchOS)
import Foundation
import SensorKit
extension SRSensor: LampDataKeysProtocol {
    
    var dateAccessKey: String {
        String(format: "SensorKit_%@_timestamp", rawValue)
    }
    
    public var lampIdentifier: String {
        
        if #available(iOS 15.0, *) {
            if self == .siriSpeechMetrics {
                return "com.apple.sensorkit.siri_speech_metrics"
            }
            else if self == .telephonySpeechMetrics {
                return "com.apple.sensorkit.telephony_speech_metrics"
            }
        }
        
        switch self {
        case .deviceUsageReport:
            return "com.apple.sensorkit.device_usage"
        case .ambientLightSensor:
            return "com.apple.sensorkit.ambient_light"
        case .keyboardMetrics:
            return "com.apple.sensorkit.keyboard_metrics"
        case .phoneUsageReport:
            return "com.apple.sensorkit.phone_usage"
        case .messagesUsageReport:
            return "com.apple.sensorkit.messages_usage"
        case .visits:
            return "com.apple.sensorkit.visits"
        case .onWristState:
            return "com.apple.sensorkit.wrist_state"
        default:
            return self.rawValue
        }
    }
    
    static func startDateOf(sensor: SRSensor) -> SRAbsoluteTime {
        let key = sensor.dateAccessKey
        if let startDate = (UserDefaults.standard.object(forKey: key) as? SRAbsoluteTime) {
            return startDate
        } else if let startDate = (UserDefaults.standard.object(forKey: key) as? Date) {
            return (startDate as NSDate).srAbsoluteTime
        }
        else {
            let startDate = (Date().pastTenMinutes as NSDate).srAbsoluteTime
            setStartDate(startDate, sensor: sensor)
            return startDate
        }
    }
    
    static func setStartDate(_ date: SRAbsoluteTime, sensor: SRSensor) {
        let key = sensor.dateAccessKey
        UserDefaults.standard.set(date, forKey: key)
    }
    
    static func getSRSensorsFrom(identifiers: [String]) -> [SRSensor] {
        var allConfiguredSensors = Set<SRSensor>()
        identifiers.forEach {
            switch $0 {
            case SRSensor.deviceUsageReport.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.deviceUsageReport)
            case SRSensor.ambientLightSensor.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.ambientLightSensor)
            case SRSensor.keyboardMetrics.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.keyboardMetrics)
            case SRSensor.phoneUsageReport.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.phoneUsageReport)
            case SRSensor.messagesUsageReport.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.messagesUsageReport)
            case SRSensor.visits.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.visits)
            case SRSensor.onWristState.lampIdentifier:
                allConfiguredSensors.insert(SRSensor.onWristState)
            default:
                break
            }
        }
        if #available(iOS 15.0, *) {
            if identifiers.contains(SRSensor.siriSpeechMetrics.lampIdentifier) {
                allConfiguredSensors.insert(SRSensor.siriSpeechMetrics)
            }
            if identifiers.contains(SRSensor.telephonySpeechMetrics.lampIdentifier) {
                allConfiguredSensors.insert(SRSensor.telephonySpeechMetrics)
            }
        }
        return Array(allConfiguredSensors)
    }
}

#endif
