//
//  LampSensorCoreUtils.swift
//  mindLAMP Consortium
//
//  Created by ZCO Engineer on 13/01/20.
//

import Foundation

public class LampSensorCoreUtils {

    public static func getTimeZone() -> Int {
        let secondsFromGMT = TimeZone.current.secondsFromGMT()
        return secondsFromGMT/60/60 // convert a secounds -> hours
    }
}
