//
//  SensorDelegate.swift
//  mindlamp
//
//  Created by ZCO Engineer on 06/05/22.
//
#if !os(watchOS)

import Foundation
import SensorKit
import Speech

extension Encodable {
  var convertToDict: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
  }
}

class SRSensorDelegate: NSObject, SRSensorReaderDelegate {
    
    weak var callbackdelegate: SensorKitObserver?
    
    var frequencySettings: [String: SRSensorLoader.Config]?
    
//    private func processResult(_ result: SRFetchResult<AnyObject>, sensor: SRSensor) {
//
//        guard let sample = result.sample as? Encodable, let json = sample.convertToDict else { return }
//        let date = NSDate(srAbsoluteTime: result.timestamp)
//        let model =  SensorKitEvent(timestamp: date.timeIntervalSince1970 * 1000, sensor: sensor.lampIdentifier, data: json)
//        callbackdelegate?.onSensorFetch(model)
//    }
    
    private func processResult(_ result: SRFetchResult<AnyObject>, sensor: SRSensor) {

        var sample: Encodable?
        if let wristDetection = result.sample as? SRWristDetection {
            sample = SRWristDetectionCustom(wristDetection)
        } else if let visit = result.sample as? SRVisit {
            sample = SRVisitCustom(visit)
        } else if let keyboardMetrics = result.sample as? SRKeyboardMetrics {
            sample = SRKeyboardMetricsCustom(keyboardMetrics)
        } else if let messageUsage = result.sample as? SRMessagesUsageReport {
            sample = SRMessagesUsageReportCustom(messageUsage)
        } else if let deviceUsage = result.sample as? SRDeviceUsageReport {
            sample = SRDeviceUsageReportCustom(deviceUsage)
        } else if let phoneUsage = result.sample as? SRPhoneUsageReport {
            sample = SRPhoneUsageReportCustom(phoneUsage)
        } else if let lightSample = result.sample as? SRAmbientLightSample {
            sample = SRAmbientLightSampleCustom(lightSample)
        } else if let speechRecognitionResult = result.sample as? SFSpeechRecognitionResult {
            if #available(iOS 15.0, *) {
                sample = SFSpeechRecognitionResultCustom(speechRecognitionResult)
            }
        }
        guard let json = sample?.convertToDict else { return }
        let date = NSDate(srAbsoluteTime: result.timestamp)
        let model =  SensorKitEvent(timestamp: date.timeIntervalInMilli, sensor: sensor.lampIdentifier, data: json)
        callbackdelegate?.onSensorFetch(model)
    }
    
    func sensorReader(_ reader: SRSensorReader, fetching fetchRequest: SRFetchRequest, didFetchResult result: SRFetchResult<AnyObject>) -> Bool {
        
        let timestamp = result.timestamp
        if let intervalInMillli = frequencySettings?[reader.sensor.lampIdentifier]?.intervalMilliSeconds {
            let diffMilliSeconds = NSDate(srAbsoluteTime: timestamp).timeIntervalInMilli - NSDate(srAbsoluteTime: SRSensor.startDateOf(sensor: reader.sensor)).timeIntervalInMilli
            if diffMilliSeconds < intervalInMillli {
                return true
            }
        }
        
        processResult(result, sensor: reader.sensor)
        SRSensor.setStartDate(timestamp, sensor: reader.sensor)
        return true
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

extension NSDate {
    var timeIntervalInMilli: Double {
        timeIntervalSince1970 * 1000.0
    }
}

extension Date {
    var timeIntervalInMilli: Double {
        timeIntervalSince1970 * 1000.0
    }
}


#endif
