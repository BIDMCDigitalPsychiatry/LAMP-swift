//
//  AccelerometerEvent.swift
//  mindLAMP Consortium
//
//  Created by ZCO Engineer on 13/01/20.
//

import Foundation
import CoreMotion

public class AccelerometerData {
    
    public var timestamp: Double
    public var acceleration: CMAcceleration
    
    init(_ acceleration: CMAcceleration) {
        self.acceleration = acceleration
        timestamp = Date().timeInMilliSeconds
    }
    
    init(_ acceleration: CMAcceleration, timeStamp: TimeInterval) {
        self.acceleration = acceleration
        self.timestamp = timeStamp * 1000
    }
}
