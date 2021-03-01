//
//  File.swift
//  
//
//

import Foundation

public enum ScreenState: Int {
    
    case screen_on
    case screen_off
    case screen_locked
    case screen_unlocked
}

extension ScreenState: TextPresentation {
    public var stringValue: String? {
    switch self {
    
    case .screen_on:
        return "screen_on"
    case .screen_off:
        return "screen_off"
    case .screen_locked:
        return "locked"
    case .screen_unlocked:
        return "unlocked"
        }
    }
}

public struct ScreenStateData {
    
    public var screenState: ScreenState = .screen_on
    public var timestamp: Double = Date().timeIntervalSince1970 * 1000
}
