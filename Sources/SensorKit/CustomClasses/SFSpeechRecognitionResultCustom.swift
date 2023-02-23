//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//
#if !os(watchOS)
import Foundation
import Speech

@available(iOS 15.0, *)
class SFSpeechRecognitionResultCustom: Encodable {
    
    var bestTranscription: SFTranscriptionCustom
    var transcriptions: [SFTranscriptionCustom]
    var speechRecognitionMetadata: SFSpeechRecognitionMetadataCustom?
    var isFinal: Bool

    init(_ speechRecognitionResult: SFSpeechRecognitionResult) {
        self.bestTranscription = SFTranscriptionCustom(speechRecognitionResult.bestTranscription)
        self.transcriptions = speechRecognitionResult.transcriptions.map({SFTranscriptionCustom($0)})
        self.speechRecognitionMetadata = SFSpeechRecognitionMetadataCustom(speechRecognitionResult.speechRecognitionMetadata)
        self.isFinal = speechRecognitionResult.isFinal
    }
}

@available(iOS 15.0, *)
class SFSpeechRecognitionMetadataCustom: Encodable {
    
    class SFVoiceAnalyticsCustom: Encodable {
        
        class SFAcousticFeatureCustom: Encodable {
            var frameDuration: TimeInterval
            
            init(_ feature: SFAcousticFeature) {
                self.frameDuration = feature.frameDuration.toMilliSeconds
            }
        }
        
        var jitter: SFAcousticFeatureCustom
        var shimmer: SFAcousticFeatureCustom
        var pitch: SFAcousticFeatureCustom
        var voicing: SFAcousticFeatureCustom
        
        init?(_ analytics: SFVoiceAnalytics?) {
            guard let nonNilanalytics = analytics else { return nil }
            self.jitter = SFAcousticFeatureCustom(nonNilanalytics.jitter)
            self.shimmer = SFAcousticFeatureCustom(nonNilanalytics.shimmer)
            self.pitch = SFAcousticFeatureCustom(nonNilanalytics.pitch)
            self.voicing = SFAcousticFeatureCustom(nonNilanalytics.voicing)
        }
    }

    
    var speakingRate: Double
    var averagePauseDuration: TimeInterval
    var speechStartTimestamp: TimeInterval
    var speechDuration: TimeInterval
    var voiceAnalytics: SFVoiceAnalyticsCustom?
    
    init?(_ metadata: SFSpeechRecognitionMetadata?) {
        guard let nonNilMetatdata = metadata else { return nil }
        self.speakingRate = nonNilMetatdata.speakingRate
        self.averagePauseDuration = nonNilMetatdata.averagePauseDuration.toMilliSeconds
        self.speechStartTimestamp = nonNilMetatdata.speechStartTimestamp.toMilliSeconds
        self.speechDuration = nonNilMetatdata.speechDuration.toMilliSeconds
        self.voiceAnalytics = SFVoiceAnalyticsCustom(nonNilMetatdata.voiceAnalytics)
    }
}

@available(iOS 15.0, *)
class SFTranscriptionCustom: Encodable {
    var formattedString: String
    var segments: [SFTranscriptionSegmentCustom]
    
    init(_ transcription: SFTranscription) {
        self.formattedString = transcription.formattedString
        self.segments = transcription.segments.map({SFTranscriptionSegmentCustom($0)})
    }
}

@available(iOS 15.0, *)
class SFTranscriptionSegmentCustom: Encodable {
    
    var substring: String
    var substringRange: NSRange
    var timestamp: TimeInterval
    var duration: TimeInterval
    var confidence: Float
    var alternativeSubstrings: [String]
    
    init(_ transcriptionSegment: SFTranscriptionSegment) {
        self.substring = transcriptionSegment.substring
        self.substringRange = transcriptionSegment.substringRange
        self.timestamp = transcriptionSegment.timestamp.toMilliSeconds
        self.duration = transcriptionSegment.duration.toMilliSeconds
        self.confidence = transcriptionSegment.confidence
        self.alternativeSubstrings = transcriptionSegment.alternativeSubstrings
    }
}

#endif
