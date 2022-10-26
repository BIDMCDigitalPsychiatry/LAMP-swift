//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRMessagesUsageReportCustom: Encodable {
    
    var duration: TimeInterval
    var totalOutgoingMessages: Int
    var totalIncomingMessages: Int
    var totalUniqueContacts: Int
    
    init(_ messageUsageReport: SRMessagesUsageReport) {
        self.duration = messageUsageReport.duration * 1000
        self.totalOutgoingMessages = messageUsageReport.totalOutgoingMessages
        self.totalIncomingMessages = messageUsageReport.totalIncomingMessages
        self.totalUniqueContacts = messageUsageReport.totalUniqueContacts
    }
}

#endif
