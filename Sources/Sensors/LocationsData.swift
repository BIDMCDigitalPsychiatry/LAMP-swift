//
//  File.swift
//  
//
//

import Foundation
import CoreLocation

public struct LocationsData: Encodable {

    public var timestamp: Double
    public var altitude:  Double
    public var latitude:  Double
    public var longitude: Double
    public var accuracy: Double
    
    init(_ location: CLLocation, eventTime: Date?) {
        timestamp = eventTime != nil ? eventTime!.timeIntervalSince1970 * 1000 : Date().timeIntervalSince1970 * 1000
        altitude = location.altitude
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        accuracy = location.horizontalAccuracy
    }
    
    enum CodingKeys: String, CodingKey {
        case altitude
        case latitude
        case longitude
        case accuracy
    }
}
