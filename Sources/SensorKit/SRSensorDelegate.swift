//
//  SensorDelegate.swift
//  mindlamp
//
//  Created by Jijo Pulikkottil on 06/05/22.
//
#if !os(watchOS)

import Foundation
import SensorKit
import Speech

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
  }
}

extension SRSensor: LampDataKeysProtocol {
    
    public var lampIdentifier: String {
        
        if #available(iOS 15.0, *) {
            if self == .siriSpeechMetrics {
                return self.rawValue
            }
            else if self == .telephonySpeechMetrics {
                return self.rawValue
            }
        }
        
        switch self {
        case .deviceUsageReport:
            return self.rawValue
        case .ambientLightSensor:
            return self.rawValue
        case .keyboardMetrics:
            return self.rawValue
        default:
            return self.rawValue
        }
    }
}


class SRSensorDelegate: NSObject, SRSensorReaderDelegate {
    
    weak var delegate: SensorKitObserver?
    
    func sensorReader(_ reader: SRSensorReader, fetching fetchRequest: SRFetchRequest, didFetchResult result: SRFetchResult<AnyObject>) -> Bool {
        
        print("didFetchResult \(reader.sensor.rawValue) \(NSDate(srAbsoluteTime: result.timestamp))")
        return true
        if #available(iOS 15.0, *) {
            switch reader.sensor {
            case .deviceUsageReport:
                guard let data = result.sample as? SRDeviceUsageReport else {
                    return true
                }
            case .ambientLightSensor:
                guard let data = result.sample as? SRAmbientLightSample else {
                    return true
                }
            case .keyboardMetrics:
                guard let data = result.sample as? SRKeyboardMetrics else {
                    return true
                }
            case .messagesUsageReport:
                guard let data = result.sample as? SRMessagesUsageReport else {
                    return true
                }
            case .onWristState:
                guard let data = result.sample as? SRMessagesUsageReport else {
                    return true
                }
            case .phoneUsageReport:
                guard let data = result.sample as? SRPhoneUsageReport else {
                    return true
                }
            case .visits:
                guard let sample = result.sample as? Encodable, let json = sample.dictionary else {
                    return true
                }
                let date = NSDate(srAbsoluteTime: result.timestamp)
                let model = SRSensorModel(timestamp: date.timeIntervalSince1970 * 1000, data: json)
                delegate?.onSensorFetch(for: SensorType.lamp_sensorkit_visit.lampIdentifier, model: model)
            case .siriSpeechMetrics:
                guard let data = result.sample as? SFSpeechRecognitionResult else {
                    return true
                }
            case .telephonySpeechMetrics:
                guard let data = result.sample as? SFSpeechRecognitionMetadata else {
                    return true
                }
            default:
                return true
            }
        } else {
            // Fallback on earlier versions
            switch reader.sensor {
            case .deviceUsageReport:
                guard let data = result.sample as? SRDeviceUsageReport else {
                    return true
                }
            case .ambientLightSensor:
                guard let data = result.sample as? SRAmbientLightSample else {
                    return true
                }
            case .keyboardMetrics:
                guard let data = result.sample as? SRKeyboardMetrics else {
                    return true
                }
            case .messagesUsageReport:
                guard let data = result.sample as? SRMessagesUsageReport else {
                    return true
                }
            case .onWristState:
                guard let data = result.sample as? SRMessagesUsageReport else {
                    return true
                }
            case .phoneUsageReport:
                guard let data = result.sample as? SRPhoneUsageReport else {
                    return true
                }
            case .visits:
                guard let data = result.sample as? SRVisit else {
                    return true
                }
            default:
                return true
            }
        }
        return true
    }

    func processResult(_ result: SRFetchResult<AnyObject>, sensor: SRSensor) {
        
        guard let sample = result.sample as? Encodable, let json = sample.dictionary else { return }
        let date = NSDate(srAbsoluteTime: result.timestamp)
        let model = SRSensorModel(timestamp: date.timeIntervalSince1970 * 1000, data: json)
        delegate?.onSensorFetch(for: sensor.lampIdentifier, model: model)
    }
    
    /**
     * @brief Invoked when a fetch has been completed successfully
     */
    func sensorReader(_ reader: SRSensorReader, didCompleteFetch fetchRequest: SRFetchRequest) {
        print("didCompleteFetch \(reader.sensor.rawValue)")
    }

    /**
     * @brief Invoked when a fetch has completed with an error
     */
    func sensorReader(_ reader: SRSensorReader, fetching fetchRequest: SRFetchRequest, failedWithError error: Error) {
        print("failedWithError \(reader.sensor.rawValue) \(error.localizedDescription)")
    }

    
    /**
     * @brief Invoked when authorization status has changed
     */
    func sensorReader(_ reader: SRSensorReader, didChange authorizationStatus: SRAuthorizationStatus) {
        print("didChange authorizationStatus \(authorizationStatus.rawValue)")
        if reader.authorizationStatus == .authorized {
            reader.startRecording()
        }
    }

    
    /**
     * @brief Invoked after a SRSensorReader has request that recording be
     * started for a sensor
     */
    func sensorReaderWillStartRecording(_ reader: SRSensorReader) {
        print(#function)
    }

    
    /**
     * @brief Invoked if there was an error starting recording for a given sensor
     */
    func sensorReader(_ reader: SRSensorReader, startRecordingFailedWithError error: Error) {
        print(#function)
        print("error = \(error.localizedDescription)")
    }

    
    /**
     * @brief Invoked after a SRSensorReader has request that recording be
     * stopped for a sensor
     */
    func sensorReaderDidStopRecording(_ reader: SRSensorReader) {
        print(#function)
    }

    
    /**
     * @brief Invoked if there was an error starting recording for a given sensor
     */
    func sensorReader(_ reader: SRSensorReader, stopRecordingFailedWithError error: Error) {
        print("stopRecordingFailedWithError")
        print("error = \(error.localizedDescription)")
    }

    
    func sensorReader(_ reader: SRSensorReader, didFetch devices: [SRDevice]) {
        print("didFetch Devices")
    }

    func sensorReader(_ reader: SRSensorReader, fetchDevicesDidFailWithError error: Error) {
        print("fetchDevicesDidFailWithError \(error.localizedDescription)")
    }
}

#endif
