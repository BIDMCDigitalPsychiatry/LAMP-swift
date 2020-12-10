//
// ActivitySpec.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

/** The ActivitySpec determines the parameters and properties of an Activity and its corresponding generated ActivityEvents. */

@objc public class ActivitySpec: NSObject, Codable { 

    /** The name of the activity spec. */
    public var name: String?
    /** Either a binary blob containing a document or video, or a string containing  instructional aid about the Activity. */
    public var helpContents: String?
    /** The WebView-compatible script that provides this Activity on mobile or desktop (IFrame) clients. */
    public var scriptContents: String?
    /** The static data definition of an ActivitySpec. */
    public var staticDataSchema: Any?
    /** The temporal event data definition of an ActivitySpec. */
    public var temporalEventSchema: Any?
    /** The Activity settings definition of an ActivitySpec. */
    public var settingsSchema: Any?

    public init(name: String?, helpContents: String?, scriptContents: String?, staticDataSchema: Any?, temporalEventSchema: Any?, settingsSchema: Any?) {
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