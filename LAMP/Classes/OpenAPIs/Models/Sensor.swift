//
// Sensor.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

/** A sensor that may or may not be available on a physical device. */

@objc public class Sensor: NSObject, Codable { 

    /** A globally unique reference for objects. */
    public var _id: String?
    /** A globally unique reference for objects. */
    public var spec: String?
    /** The name of the sensor. */
    public var name: String?
    /** The configuration settings for the sensor. */
    public var settings: Any?

    public init(_id: String?, spec: String?, name: String?, settings: Any?) {
        self._id = _id
        self.spec = spec
        self.name = name
        self.settings = settings
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case _id = "id"
        case spec
        case name
        case settings
    }

}
