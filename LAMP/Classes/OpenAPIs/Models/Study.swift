//
// Study.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



@objc public class Study: NSObject, Codable { 

    /** A globally unique reference for objects. */
    public var _id: String?
    /** The name of the study. */
    public var name: String?
    /** The set of all activities available in the study. */
    public var activities: [Any]?
    /** The set of all enrolled participants in the study. */
    public var participants: [Any]?

    public init(_id: String?, name: String?, activities: [Any]?, participants: [Any]?) {
        self._id = _id
        self.name = name
        self.activities = activities
        self.participants = participants
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case _id = "id"
        case name
        case activities
        case participants
    }

}
