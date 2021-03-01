#if canImport(UIKit)
import Foundation
import UIKit

public protocol ScreenStateObserver: class {
    func onDataChanged(data: ScreenStateData)
}

public class ScreenSensor: ISensorController {
 
    public var latestScreenState: ScreenState?
    var timer: Timer?
    public var config = ScreenSensor.Config()
    
    public class Config: SensorConfig {
        
        public var interval = 1.0 // in seconds
        public weak var sensorObserver: ScreenStateObserver?
        
        public override init() {
            super.init()
        }
      
        public func apply(closure: (_ config: ScreenSensor.Config ) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    @objc
    func fetchScreenState() {
        #if os(iOS)
        DispatchQueue.main.async { [weak self] in
            let screnState: ScreenState
            if UIApplication.shared.isProtectedDataAvailable {
                
                if UIScreen.main.brightness == 0.0 {
                    screnState = .screen_off
                } else {
                    screnState = .screen_on
                }
                //ScreenStateData(screenState: .screen_unlocked)
            } else {
                screnState = .screen_locked
            }
            
            if self?.latestScreenState?.rawValue != screnState.rawValue {
                let screenData = ScreenStateData(batteryLevel: BatteryState.shared.batteryLevel(), screenState: screnState)
                self?.config.sensorObserver?.onDataChanged(data: screenData)
            }
            self?.latestScreenState = screnState
        }
        #endif
    }
    public convenience init() {
        self.init(ScreenSensor.Config())
    }
    
    public init(_ config: ScreenSensor.Config) {
        self.config = config
    }
    public func start() {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: config.interval, target: self, selector: #selector(fetchScreenState), userInfo: nil, repeats: true)
        }
    }
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}
#endif
