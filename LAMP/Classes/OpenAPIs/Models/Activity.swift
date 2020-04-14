//
// Activity.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

/** An activity that may be performed by a participant in a study. */

@objc public class Activity: NSObject, Codable { 

    /** A globally unique reference for objects. */
    public var _id: String?
    /** A globally unique reference for objects. */
    public var spec: String?
    /** The name of the activity. */
    public var name: String?
    public var schedule: DurationIntervalLegacy?
    /** The configuration settings for the activity. */
    public var settings: Any?

    public init(_id: String?, spec: String?, name: String?, schedule: DurationIntervalLegacy?, settings: Any?) {
        self._id = _id
        self.spec = spec
        self.name = name
        self.schedule = schedule
        self.settings = settings
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case _id = "id"
        case spec
        case name
        case schedule
        case settings
    }

}
