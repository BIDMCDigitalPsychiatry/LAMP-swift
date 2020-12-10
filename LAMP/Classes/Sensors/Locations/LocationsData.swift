//
//  LocationsData.swift
//  mindLAMP Consortium
//
import CoreLocation

public struct LocationsData {

    public var timestamp: Double
    public var altitude:  Double
    public var latitude:  Double
    public var longitude: Double
    
    init(_ location: CLLocation, eventTime: Date?) {
        timestamp = eventTime != nil ? eventTime!.timeInMilliSeconds : Date().timeInMilliSeconds
        altitude = location.altitude
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}






