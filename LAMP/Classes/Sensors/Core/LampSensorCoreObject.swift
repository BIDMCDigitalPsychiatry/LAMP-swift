//
//  LampSensorCoreObject.swift
//  mindLAMP Consortium
//
//  Created by ZCO Engineer on 13/01/20.
//

import Foundation

public class LampSensorCoreObject {
    
    public var timestampInternal: Int64 = Int64(Date().timeIntervalSince1970*1000)
    open func toDictionary() -> Dictionary<String, Any> {
        let dict = ["timestamp": timestampInternal]
        return dict
    }
    public init() {}
}


