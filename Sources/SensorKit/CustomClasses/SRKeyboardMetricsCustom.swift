//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRKeyboardMetricsCustom: Encodable {
    
    var duration: TimeInterval
    var keyboardIdentifier: String
    var version: String
    var width: Measurement<UnitLength>
    var height: Measurement<UnitLength>
    var inputModes: [String]?
    
    init(_ keyboardMetrics: SRKeyboardMetrics) {
        self.duration = keyboardMetrics.duration.toMilliSeconds
        self.keyboardIdentifier = keyboardMetrics.keyboardIdentifier
        self.version = keyboardMetrics.version
        self.width = keyboardMetrics.width
        self.height = keyboardMetrics.height
        if #available(iOS 15.0, *) {
            self.inputModes = keyboardMetrics.inputModes
        }
    }
}

#endif
