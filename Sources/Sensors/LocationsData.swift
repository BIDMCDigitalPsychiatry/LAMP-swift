//
//  File.swift
//  
//
//

import Foundation
import CoreLocation

public struct LocationsData {

    public var timestamp: Double
    public var altitude:  Double
    public var latitude:  Double
    public var longitude: Double
    
    init(_ location: CLLocation, eventTime: Date?) {
        timestamp = eventTime != nil ? eventTime!.timeIntervalSince1970 * 1000 : Date().timeIntervalSince1970 * 1000
        altitude = location.altitude
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
