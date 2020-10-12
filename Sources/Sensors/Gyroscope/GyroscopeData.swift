//
//  GyroscopeData.swift
//  mindLAMP Consortium
//
import CoreMotion

public class GyroscopeData {

    public var timestamp: Double
    public var rotationRate: CMRotationRate
    
    init(_ rotationRate: CMRotationRate) {
        self.rotationRate = rotationRate
        timestamp = Date().timeInMilliSeconds
    }
}
