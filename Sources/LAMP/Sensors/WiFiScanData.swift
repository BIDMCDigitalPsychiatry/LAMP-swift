//
//  File.swift
//  
//

import Foundation

public class WiFiScanData {
    
    public var timestamp = Date().timeIntervalSince1970 * 1000
    public var bssid: String = ""
    public var ssid: String  = ""
    
    public var security: String = ""
    public var frequency: Int = 0
    public var rssi: Int = 0
}
