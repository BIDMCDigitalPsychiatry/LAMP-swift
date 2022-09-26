//
//  File.swift
//  mindlamp
//
//  Created by ZCO Engineer on 10/05/22.
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

extension SRWristDetection: Encodable {
    private enum CodingKeys: String, CodingKey {
        case crownOrientation
        case onWrist
        case wristLocation
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(crownOrientation.rawValue, forKey: .crownOrientation)
        try container.encode(onWrist, forKey: .onWrist)
        try container.encode(wristLocation.rawValue, forKey: .wristLocation)
    }
}


extension SRVisit: Encodable {
    private enum CodingKeys: String, CodingKey {
        case arrivalDateInterval
        case departureDateInterval
        case distanceFromHome
        case locationCategory
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(arrivalDateInterval, forKey: .arrivalDateInterval)
        try container.encode(departureDateInterval, forKey: .departureDateInterval)
        try container.encode(distanceFromHome, forKey: .distanceFromHome)
        try container.encode(locationCategory.rawValue, forKey: .locationCategory)
    }
}

extension SRKeyboardMetrics: Encodable {
    private enum CodingKeys: String, CodingKey {
        case duration
        case keyboardIdentifier
        case version
        case width
        case height
        case inputModes
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(keyboardIdentifier, forKey: .keyboardIdentifier)
        try container.encode(version, forKey: .version)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        if #available(iOS 15.0, *) {
            try container.encode(inputModes, forKey: .inputModes)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension SRMessagesUsageReport: Encodable {
    private enum CodingKeys: String, CodingKey {
        case duration
        case totalIncomingMessages
        case totalOutgoingMessages
        case totalUniqueContacts
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(totalIncomingMessages, forKey: .totalIncomingMessages)
        try container.encode(totalOutgoingMessages, forKey: .totalOutgoingMessages)
        try container.encode(totalUniqueContacts, forKey: .totalUniqueContacts)
    }
}

extension SRDeviceUsageReport: Encodable {
    private enum CodingKeys: String, CodingKey {
        case duration
        case totalScreenWakes
        case totalUnlocks
        case totalUnlockDuration
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(totalScreenWakes, forKey: .totalScreenWakes)
        try container.encode(totalUnlocks, forKey: .totalUnlocks)
        try container.encode(totalUnlockDuration, forKey: .totalUnlockDuration)
    }
}

extension SRPhoneUsageReport: Encodable {
    private enum CodingKeys: String, CodingKey {
        case duration
        case totalIncomingCalls
        case totalOutgoingCalls
        case totalPhoneCallDuration
        case totalUniqueContacts
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(totalIncomingCalls, forKey: .totalIncomingCalls)
        try container.encode(totalOutgoingCalls, forKey: .totalOutgoingCalls)
        try container.encode(totalPhoneCallDuration, forKey: .totalPhoneCallDuration)
        try container.encode(totalUniqueContacts, forKey: .totalUniqueContacts)
    }
}

extension SRAmbientLightSample.Chromaticity: Encodable {
    private enum CodingKeys: String, CodingKey {
        case x
        case y
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }
}

extension SRAmbientLightSample: Encodable {
    private enum CodingKeys: String, CodingKey {
        case chromaticity
        case lux
        case placement
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(chromaticity, forKey: .chromaticity)
        try container.encode(lux, forKey: .lux)
        try container.encode(placement.rawValue, forKey: .placement)
    }
}
@available(iOS 15.0, *)
extension SFSpeechRecognitionResult: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case bestTranscription
        case transcriptions
        case speechRecognitionMetadata
        case isFinal
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bestTranscription, forKey: .bestTranscription)
        try container.encode(transcriptions, forKey: .transcriptions)
        try container.encode(speechRecognitionMetadata, forKey: .speechRecognitionMetadata)
        try container.encode(isFinal, forKey: .isFinal)
    }
}

extension SFTranscription: Encodable {
    private enum CodingKeys: String, CodingKey {
        case formattedString
        case segments
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formattedString, forKey: .formattedString)
        try container.encode(segments, forKey: .segments)
    }
}
@available(iOS 14.5, *)
extension SFSpeechRecognitionMetadata: Encodable {
    private enum CodingKeys: String, CodingKey {
        case averagePauseDuration
        case speakingRate
        case speechDuration
        case speechStartTimestamp
        //case voiceAnalytics
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(averagePauseDuration, forKey: .averagePauseDuration)
        try container.encode(speakingRate, forKey: .speakingRate)
        try container.encode(speechDuration, forKey: .speechDuration)
        try container.encode(speechStartTimestamp, forKey: .speechStartTimestamp)
        //try container.encode(voiceAnalytics, forKey: .voiceAnalytics)
    }
}

extension SFTranscriptionSegment: Encodable {
    private enum CodingKeys: String, CodingKey {
        case substring
        case substringRange
        case alternativeSubstrings
        case confidence
        case timestamp
        case duration
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(substring, forKey: .substring)
        try container.encode(substringRange, forKey: .substringRange)
        try container.encode(alternativeSubstrings, forKey: .alternativeSubstrings)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(duration, forKey: .duration)
    }
}
#endif
