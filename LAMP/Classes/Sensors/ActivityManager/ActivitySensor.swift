//
//  ActivitySensor.swift
//  
//
//  Created by ZCO Engineer on 26/11/20.
//

import Foundation
import CoreMotion

public protocol ActivitySensorObserver: class {
    func onDataChanged(data: ActivityData)
}

public class ActivitySensor: ISensorController {
    
    let activityManager: CMMotionActivityManager
    public weak var sensorObserver: ActivitySensorObserver?
    
    private let opQueue: OperationQueue = {
        let o = OperationQueue()
        o.name = "ActivitySensor-updates"
        return o
    }()
    
    public init() {
        activityManager = CMMotionActivityManager()
    }
    
    public func start() {
        activityManager.startActivityUpdates(to: opQueue) { [weak self] (motionActivity) in
            guard let activity = motionActivity else {return}
            self?.sensorObserver?.onDataChanged(data: ActivityData(activity))
        }
    }
    
    public func stop() {
        activityManager.stopActivityUpdates()
    }
}
