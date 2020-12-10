// mindLAMP

import Foundation
import CoreMotion

extension CMSensorDataList: Sequence {
    public typealias Iterator = NSFastEnumerationIterator

    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self)
    }
}

public class LMSensorRecorder {
    
    //let activityManager = CMMotionActivityManager()
    let sensorRecorder: CMSensorRecorder
    //var recordingStartDate: Date?
    let duration: TimeInterval
    
    public init(_ duration: TimeInterval? = nil) {
//        self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: {(data: CMMotionActivity!) -> Void in
//
//        })
        self.duration = duration ?? 12.0 * 60.0 * 60.0 //in seconds //12 hours is the maximum
        sensorRecorder = CMSensorRecorder()
        //this is for prompting permission
        DispatchQueue.global(qos: .background).async {
            self.sensorRecorder.recordAccelerometer(forDuration: 1)
        }
    }
    
    public func startReadingAccelorometerData() {
        if CMSensorRecorder.isAccelerometerRecordingAvailable() {
            
            if CMSensorRecorder.authorizationStatus() == .authorized {
                print("Authorized.......")
                //if recordingStartDate == nil || recordingStartDate!.addingTimeInterval(duration) < Date() {
                    
                    DispatchQueue.global(qos: .background).async {
                        //self.recordingStartDate = Date()
                        self.sensorRecorder.recordAccelerometer(forDuration: self.duration)
                    }
                //}
                
            } else {
                print("not authorized")
            }
        } else {
            print("NOt available for recording")
        }
    }
    
    
    public func getRecordedData(from: Date, to: Date) -> [AccelerometerData]? {
        //if to < self.recordingStartDate!.addingTimeInterval(duration) {
            let startTime = from//self.lastFetchedDate ?? self.recordingStartDate!
            let endTime = to//startTime.addingTimeInterval(10 * 60)
            guard let sensorData = self.sensorRecorder.accelerometerData(from: startTime, to:endTime) else {
                //startReadingAccelorometerData()//TODO: no need this
                return nil
            }
            return sensorData.compactMap { (datum) -> AccelerometerData? in
                if let accdatum = datum as? CMRecordedAccelerometerData {
                    let accel = accdatum.acceleration
                    let t = accdatum.startDate.timeIntervalSince1970
                    return AccelerometerData(accel, timeStamp: t)
                }
                return nil
            }
//        } else {
//            startReadingAccelorometerData()
//        }
        return nil
    }
}
