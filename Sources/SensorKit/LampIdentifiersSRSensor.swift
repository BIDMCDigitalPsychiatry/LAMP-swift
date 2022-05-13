//
//  File.swift
//  
//
//  Created by Jijo Pulikkottil on 12/05/22.
//
#if !os(watchOS)
import Foundation
import SensorKit
extension SRSensor: LampDataKeysProtocol {
    
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
}

#endif
