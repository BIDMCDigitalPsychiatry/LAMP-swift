//
// ActivityEvent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

/** An event generated by the participant interacting with an &#x60;Activity&#x60;. */

@objc public class ActivityEvent: NSObject, Codable { 

    /** The UNIX Epoch date-time representation: number of milliseconds since 1/1/1970 12:00 AM. */
    public var timestamp: Double?
    /** The duration this event lasted before recording ended. */
    public var duration: Int64?
    public var durationNum: NSNumber? {
        get {
            return duration as NSNumber?
        }
    }
    /** A globally unique reference for objects. */
    public var activity: String?
    /** The summary information for the activity event as determined by the activity that created this activity event. */
    public var data: Any?
    /** The specific interaction details of the activity event. */
    public var temporalSlices: [Any]?

    public init(timestamp: Double?, duration: Int64?, activity: String?, data: Any?, temporalSlices: [Any]?) {
        self.timestamp = timestamp
        self.duration = duration
        self.activity = activity
        self.data = data
        self.temporalSlices = temporalSlices
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case timestamp
        case duration
        case activity
        case data
        case temporalSlices = "temporal_slices"
    }

}
