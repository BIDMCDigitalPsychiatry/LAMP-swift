// mindLAMP
#if !os(macOS)
import Foundation
import UIKit
//https://github.com/orgs/BIDMCDigitalPsychiatry/teams/native-core/discussions/1

public class BatteryState {
    
    //private var isLowPower = false
    public static let shared = BatteryState()
    
    public var isLowPowerEnabled: Bool {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return isBatteryLevelLow()
        } else {
            return ProcessInfo.processInfo.isLowPowerModeEnabled
        }
        #elseif os(watchOS)
        return ProcessInfo.processInfo.isLowPowerModeEnabled
        #endif
    }
    
    private init() {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            UIDevice.current.isBatteryMonitoringEnabled = true
        } else {
//            isLowPower = ProcessInfo.processInfo.isLowPowerModeEnabled
//            // Set up an observer.
//            NotificationCenter.default.addObserver(self, selector: #selector(didChangePowerMode(_:)), name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        }
//        #elseif os(watchOS)
//        isLowPower = ProcessInfo.processInfo.isLowPowerModeEnabled
//        // Set up an observer.
//        NotificationCenter.default.addObserver(self, selector: #selector(didChangePowerMode(_:)), name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        #endif
        
    }
    
//    @objc
//    func didChangePowerMode(_ notification: NSNotification) {
//        printToFile("\n ProcessInfo.processInfo.isLowPowerModeEnabled = \(ProcessInfo.processInfo.isLowPowerModeEnabled)")
//        if ProcessInfo.processInfo.isLowPowerModeEnabled {
//            // Low power mode was turned on
//            isLowPower = true
//        } else {
//            // Low power mode was turned off
//            isLowPower = false
//        }
//    }
    
    #if os(iOS)
    private func isBatteryLevelLow(than level: Float = 20) -> Bool {
        return UIDevice.current.batteryLevel < level/100
    }
    #endif
    public func batteryLevel() -> Float? {
        #if os(iOS)
        return UIDevice.current.batteryLevel
        #else
        return nil
        #endif
    }
}
#endif
