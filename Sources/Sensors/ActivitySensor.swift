import Foundation
import CoreMotion

public class ActivityData {
    
    public var timestamp: Double
    public var activity: CMMotionActivity

    init(_ activity: CMMotionActivity, timeStamp: TimeInterval = Date().timeIntervalSince1970) {
        self.activity = activity
        self.timestamp = timeStamp * 1000
    }
}

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
