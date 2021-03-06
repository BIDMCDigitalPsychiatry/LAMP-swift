//
// ActivitySpec.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
//import AnyCodable

/** The ActivitySpec determines the parameters and properties of an Activity and its corresponding generated ActivityEvents. */
public struct ActivitySpec: Codable {

    /** The name of the activity spec. */
    public var name: String?
    /** Either a binary blob containing a document or video, or a string containing  instructional aid about the Activity. */
    public var helpContents: String?
    /** The WebView-compatible script that provides this Activity on mobile or desktop (IFrame) clients. */
    public var scriptContents: String?
    /** The static data definition of an ActivitySpec. */
    public var staticDataSchema: AnyCodable?
    /** The temporal event data definition of an ActivitySpec. */
    public var temporalEventSchema: AnyCodable?
    /** The Activity settings definition of an ActivitySpec. */
    public var settingsSchema: AnyCodable?

    public init(name: String? = nil, helpContents: String? = nil, scriptContents: String? = nil, staticDataSchema: AnyCodable? = nil, temporalEventSchema: AnyCodable? = nil, settingsSchema: AnyCodable? = nil) {
        self.name = name
        self.helpContents = helpContents
        self.scriptContents = scriptContents
        self.staticDataSchema = staticDataSchema
        self.temporalEventSchema = temporalEventSchema
        self.settingsSchema = settingsSchema
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case name
        case helpContents = "help_contents"
        case scriptContents = "script_contents"
        case staticDataSchema = "static_data_schema"
        case temporalEventSchema = "temporal_event_schema"
        case settingsSchema = "settings_schema"
    }

}

