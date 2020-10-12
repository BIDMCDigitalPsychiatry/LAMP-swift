//
//  MotionData.swift
//  
//
//  mindLAMP Consortium
//

import Foundation
import CoreMotion

public struct DeviceAttitude {
    public var roll: Double
    public var pitch: Double
    public var yaw: Double
}

public class MotionData {
    
    public var timestamp: Double
    
    public var acceleration: CMAcceleration
    public var rotationRate: CMRotationRate
    public var magneticField: CMMagneticField
    public var gravity: CMAcceleration
    public var deviceAttitude: DeviceAttitude
    
    init(_ deviceMotion: CMDeviceMotion) {
        
        timestamp = Date().timeInMilliSeconds
        self.acceleration = deviceMotion.userAcceleration
        self.rotationRate = deviceMotion.rotationRate
        self.magneticField = deviceMotion.magneticField.field//we can check accuracy here
        self.gravity = deviceMotion.gravity
        self.deviceAttitude = DeviceAttitude(roll: deviceMotion.attitude.roll, pitch: deviceMotion.attitude.pitch, yaw: deviceMotion.attitude.yaw)
    }
}
