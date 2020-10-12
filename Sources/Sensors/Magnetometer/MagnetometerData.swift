//
//  MagnetometerData.swift
//  mindLAMP Consortium
//
import CoreMotion

public class MagnetometerData {
    
    public var timestamp: Double
    public var magnetoData: CMMagneticField
    
    init(_ magnetoData: CMMagneticField) {
        self.magnetoData = magnetoData
        timestamp = Date().timeInMilliSeconds
    }
}
