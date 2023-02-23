//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRPhoneUsageReportCustom: Encodable {
    var duration: TimeInterval
    var totalOutgoingCalls: Int
    var totalIncomingCalls: Int
    var totalUniqueContacts: Int
    var totalPhoneCallDuration: TimeInterval
    
    init(_ phoneUsageReport: SRPhoneUsageReport) {
        self.duration = phoneUsageReport.duration.toMilliSeconds
        self.totalOutgoingCalls = phoneUsageReport.totalOutgoingCalls
        self.totalIncomingCalls = phoneUsageReport.totalIncomingCalls
        self.totalUniqueContacts = phoneUsageReport.totalUniqueContacts
        self.totalPhoneCallDuration = phoneUsageReport.totalPhoneCallDuration
    }
}

#endif
