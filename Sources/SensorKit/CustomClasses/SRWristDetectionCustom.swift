//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRWristDetectionCustom: Encodable {
    var onWrist: Bool
    var wristLocation: Int
    var wristLocationRepresentation: String?
    var crownOrientation: Int
    var crownOrientationRepresentation: String?
    
    init (_ wristDetection: SRWristDetection) {
        self.onWrist = wristDetection.onWrist
        self.wristLocation = wristDetection.wristLocation.rawValue
        self.wristLocationRepresentation = wristDetection.wristLocation.stringValue
        self.crownOrientation = wristDetection.crownOrientation.rawValue
        self.crownOrientationRepresentation = wristDetection.crownOrientation.stringValue
    }
}

extension SRWristDetection.WristLocation: TextPresentation {
    var stringValue: String? {
        switch self {
        case .left: return "left"
        case .right: return "right"
        @unknown default: return nil
        }
    }
}

extension SRWristDetection.CrownOrientation: TextPresentation {
    var stringValue: String? {
        switch self {
        case .left: return "left"
        case .right: return "right"
        @unknown default: return nil
        }
    }
}

#endif
