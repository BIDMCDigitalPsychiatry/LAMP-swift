//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRVisitCustom: Encodable {
    
    var distanceFromHome: CLLocationDistance
    var arrivalDateInterval: DateIntervalCustom
    var departureDateInterval: DateIntervalCustom
    var locationCategory: Int
    var locationCategoryRepresentation: String?
    var identifier: UUID
    
    init(_ visit: SRVisit) {
        self.distanceFromHome = visit.distanceFromHome
        self.arrivalDateInterval = DateIntervalCustom(visit.arrivalDateInterval)
        self.departureDateInterval = DateIntervalCustom(visit.departureDateInterval)
        self.locationCategory = visit.locationCategory.rawValue
        self.locationCategoryRepresentation = visit.locationCategory.stringValue
        self.identifier = visit.identifier
    }
}

extension SRVisit.LocationCategory: TextPresentation {
    var stringValue: String? {
        switch self {
        case .gym: return "gym"
        case .home: return "home"
        case .school: return "school"
        case .unknown: return "unknown"
        case .work: return "work"
        @unknown default: return nil
        }
    }
}

struct DateIntervalCustom: Encodable {
    var start: TimeInterval
    var end: TimeInterval
    var duration: TimeInterval
    
    init(_ dateInterval: DateInterval) {
        self.start = dateInterval.start.timeIntervalInMilli
        self.end = dateInterval.end.timeIntervalInMilli
        self.duration = dateInterval.duration * 1000
    }
}
#endif
