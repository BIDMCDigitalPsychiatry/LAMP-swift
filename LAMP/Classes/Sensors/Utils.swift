//
//  File.swift
//  
//
//  Created by Jijo Pulikkottil on 06/12/20.
//

import Foundation

class Utils {
    static let shared = Utils()
    private init() {}
    
    private let timestampKey = "LMPedometerTimestamp"
    
    func getHealthKitLaunchedTimestamp() -> Date {
        let userDefaults = UserDefaults.standard
        if let date = userDefaults.object(forKey: timestampKey) as? Date {
            return date
        }
        let newDate = Date().addingTimeInterval(-10 * 60)
        userDefaults.set(newDate, forKey: timestampKey)
        return newDate
    }
    
    func removeAllSavedDates() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: timestampKey)
    }
}
