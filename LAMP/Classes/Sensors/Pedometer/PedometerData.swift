//
//  PedometerData.swift
//  mindLAMP Consortium
//

//import UIKit

public class PedometerData: LampSensorCoreObject {

    public var startDate: Double = 0
    public var endDate: Double  = 0
    public var frequencySpeed: Double  = 0
    public var numberOfSteps: Int   = 0
    public var distance: Double        = 0
    public var currentPace: Double     = 0
    public var currentCadence: Double  = 0
    public var floorsAscended: Int  = 0
    public var floorsDescended: Int = 0
    public var averageActivePace: Double = 0
    
    public var timestamp: Double {
        return endDate
    }
}
