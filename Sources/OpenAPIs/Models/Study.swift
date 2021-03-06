//
// Study.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
//import AnyCodable

public struct Study: Codable {

    /** A globally unique reference for objects. */
    public var id: String?
    /** The name of the study. */
    public var name: String?
    /** The set of all activities available in the study. */
    public var activities: [AnyCodable]?
    /** The set of all enrolled participants in the study. */
    public var participants: [AnyCodable]?

    public init(id: String? = nil, name: String? = nil, activities: [AnyCodable]? = nil, participants: [AnyCodable]? = nil) {
        self.id = id
        self.name = name
        self.activities = activities
        self.participants = participants
    }

}

