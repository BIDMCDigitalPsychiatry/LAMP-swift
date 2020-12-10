//
//  File.swift
//  
//
//  Created by Zco Engineer on 27/11/20.
//
import Foundation
import CoreMotion

public class ActivityData {
    
    public var timestamp: Double
    public var activity: CMMotionActivity
    
    init(_ activity: CMMotionActivity) {
        self.activity = activity
        timestamp = Date().timeInMilliSeconds
    }
    
    init(_ activity: CMMotionActivity, timeStamp: TimeInterval) {
        self.activity = activity
        self.timestamp = timeStamp * 1000
    }
}
