//
// Participant.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
//import AnyCodable

/** A participant within a study; a participant cannot be enrolled in more than one study at a time. */
public struct Participant: Codable {

    /** A globally unique reference for objects. */
    public var id: String?
    /** The researcher-provided study code for the participant. */
    public var studyCode: String?
    /** The participant&#39;s selected language code for the LAMP app. */
    public var language: String?
    /** The participant&#39;s selected theme for the LAMP app. */
    public var theme: String?
    /** The participant&#39;s emergency contact number. */
    public var emergencyContact: String?
    /** The participant&#39;s selected personal helpline number. */
    public var helpline: String?

    public init(id: String? = nil, studyCode: String? = nil, language: String? = nil, theme: String? = nil, emergencyContact: String? = nil, helpline: String? = nil) {
        self.id = id
        self.studyCode = studyCode
        self.language = language
        self.theme = theme
        self.emergencyContact = emergencyContact
        self.helpline = helpline
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case studyCode = "study_code"
        case language
        case theme
        case emergencyContact = "emergency_contact"
        case helpline
    }

}

