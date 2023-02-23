//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRDeviceUsageReportCustom: Encodable {
    
    var duration: TimeInterval
    var applicationUsageByCategory: [String: [SRDeviceUsageReportCustom.ApplicationUsageCustom]]!
    var notificationUsageByCategory: [String: [SRDeviceUsageReportCustom.NotificationUsageCustom]]!
    var webUsageByCategory: [String: [SRDeviceUsageReportCustom.WebUsageCustom]]!
    var totalScreenWakes: Int
    var totalUnlocks: Int
    var totalUnlockDuration: TimeInterval
    
    init(_ deviceUsageReport: SRDeviceUsageReport) {
        self.duration = deviceUsageReport.duration.toMilliSeconds
        self.applicationUsageByCategory = Dictionary(uniqueKeysWithValues: deviceUsageReport.applicationUsageByCategory.map({ key, value in
            (key.rawValue, value.map({ApplicationUsageCustom($0)})) }))
        self.notificationUsageByCategory = Dictionary(uniqueKeysWithValues: deviceUsageReport.notificationUsageByCategory.map({ key, value in
            (key.rawValue, value.map({NotificationUsageCustom($0)})) }))
        self.webUsageByCategory = Dictionary(uniqueKeysWithValues: deviceUsageReport.webUsageByCategory.map({ key, value in
            (key.rawValue, value.map({WebUsageCustom($0)})) }))
        self.totalScreenWakes = deviceUsageReport.totalScreenWakes
        self.totalUnlocks = deviceUsageReport.totalUnlocks
        self.totalUnlockDuration = deviceUsageReport.totalUnlockDuration.toMilliSeconds
    }
}

// MARK: - ApplicationUsageCustom
extension SRDeviceUsageReportCustom {
    class ApplicationUsageCustom: Encodable {
        
        var bundleIdentifier: String?
        var usageTime: TimeInterval
        var reportApplicationIdentifier: String?
        var textInputSessions: [SRTextInputSessionCustom]?
        
        init(_ applicationUsage: SRDeviceUsageReport.ApplicationUsage) {
            self.bundleIdentifier = applicationUsage.bundleIdentifier ?? "null"
            self.usageTime = applicationUsage.usageTime.toMilliSeconds
            if #available(iOS 15.0, *) {
                self.reportApplicationIdentifier = applicationUsage.reportApplicationIdentifier
                self.textInputSessions = applicationUsage.textInputSessions.compactMap { textInputSession in
                    let textinputSessionCustom = SRTextInputSessionCustom()
                    textinputSessionCustom.setInputSession(textInputSession)
                    return textinputSessionCustom
                }
            }
        }
    }
}

// MARK: - NotificationUsageCustom
extension SRDeviceUsageReportCustom {
    class NotificationUsageCustom: Encodable {
        var bundleIdentifier: String?
        var event: Int
        var eventRepresentation: String?
        
        init(_ notificationUsage: SRDeviceUsageReport.NotificationUsage) {
            self.bundleIdentifier = notificationUsage.bundleIdentifier ?? "null"
            self.event = notificationUsage.event.rawValue
            self.eventRepresentation = notificationUsage.event.stringValue
        }
    }
}

extension SRDeviceUsageReport.NotificationUsage.Event: TextPresentation {
    var stringValue: String? {
        switch self {
        case .unknown: return "unknown"
        case .received: return "received"
        case .defaultAction: return "defaultAction"
        case .supplementaryAction: return "supplementaryAction"
        case .clear: return "clear"
        case .notificationCenterClearAll: return "notificationCenterClearAll"
        case .removed: return "removed"
        case .hide: return "hide"
        case .longLook: return "longLook"
        case .silence: return "silence"
        case .appLaunch: return "appLaunch"
        case .expired: return "expired"
        case .bannerPulldown: return "bannerPulldown"
        case .tapCoalesce: return "tapCoalesce"
        case .deduped: return "deduped"
        case .deviceActivated: return "deviceActivated"
        case .deviceUnlocked: return "deviceUnlocked"
        @unknown default: return nil
        }
    }
}

// MARK: - WebUsageCustom
extension SRDeviceUsageReportCustom {
    class WebUsageCustom: Encodable {
        var totalUsageTime: TimeInterval
        init(_ webUsage: SRDeviceUsageReport.WebUsage) {
            self.totalUsageTime = webUsage.totalUsageTime.toMilliSeconds
        }
    }
}


class SRTextInputSessionCustom: Encodable {
    var duration: TimeInterval?
    var sessionType: Int?
    var sessionTypeRepresentation: String?
    
    @available(iOS 15.0, *)
    func setInputSession(_ inputSession: SRTextInputSession) {
        self.duration = inputSession.duration.toMilliSeconds
        self.sessionType = inputSession.sessionType.rawValue
        self.sessionTypeRepresentation = inputSession.sessionType.stringValue
    }
}

@available(iOS 15.0, *)
extension SRTextInputSession.SessionType: TextPresentation {
    var stringValue: String? {
        switch self {
        case .keyboard: return "keyboard"
        case .thirdPartyKeyboard: return "thirdPartyKeyboard"
        case .pencil: return "pencil"
        case .dictation: return "dictation"
        @unknown default: return nil
        }
    }
}

#endif
