//
//  File.swift
//  
//
//  Created by Zco Engineer on 11/10/20.
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
        return "Screen On"
    case .screen_off:
        return "Screen Off"
    case .screen_locked:
        return "Screen Locked"
    case .screen_unlocked:
        return "Screen Unlocked"
        }
    }
}

public struct ScreenStateData {
    
    public var screenState: ScreenState = .screen_on
    public var timestamp: Double = Date().timeInMilliSeconds
}
