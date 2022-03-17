// mindLAMP

import Foundation

public enum SensorType: LampDataKeysProtocol {
    
    public enum AnalyticAction: String {
        case login = "login"
        case notification = "notification"
        case logout = "logout"
        case logs = "log"
        case diagnostic = "diagnostic"
        case lowpowermode = "lowpowermode"
    }
    
    public struct NearbyDevicetype {
        public static var bluetooth = "bluetooth"
        public static var wifi = "wifi"
    }

    case lamp_gps
    case lamp_analytics
    case lamp_accelerometer
    case lamp_device_motion
    case lamp_steps
    case lamp_nearby_device
    case lamp_telephony
    
    //Other sensor data
    
    //case lamp_bluetooth
    //case lamp_calls
    //case lamp_gyroscope
    //case lamp_magnetometer
    case lamp_screen_state //keeping this for backward compatibility. lamp_device_state is the new name
    case lamp_device_state
    case lamp_segment
    //case lamp_sms
    //case lamp_wifi
    case lamp_Activity
    
    //CMPedometerData
    //case lamp_flights_up
    //case lamp_flights_down
    //case lamp_currentPace
    //case lamp_currentCadence
    //case lamp_avgActivePace
    //case lamp_distance
    
    
    
    public var lampIdentifier: String {
        switch self {
        case .lamp_gps:
            return "lamp.gps"
        case .lamp_analytics:
            return "lamp.analytics"
        case .lamp_device_motion:
            return "lamp.device_motion"
        case .lamp_steps:
            return "lamp.steps"
        case .lamp_nearby_device:
            return "lamp.nearby_device"
        case .lamp_telephony:
            return "lamp.telephony"
//        case .lamp_distance:
//            return "lamp.distance"
//        case .lamp_flights_up:
//            return "lamp.floors_ascended"
//        case .lamp_flights_down:
//            return "lamp.floors_descended"
        
//        case .lamp_gyroscope:
//            #if os(watchOS)
//                return "lamp.watch.gyroscope"
//            #else
//                return "lamp.gyroscope"
//            #endif
//        case .lamp_magnetometer:
//            #if os(watchOS)
//                return "lamp.watch.magnetometer"
//            #else
//                return "lamp.magnetometer"
//            #endif
        case .lamp_screen_state:
            return "lamp.screen_state"
        case .lamp_segment:
            return "lamp.segment"
//        case .lamp_sms:
//            return "lamp.sms"
//
//        case .lamp_wifi:
//            return "lamp.wifi" //d
//        case .lamp_currentPace:
//            return "lamp.current_pace"
//        case .lamp_currentCadence:
//            return "lamp.current_cadence"
//        case .lamp_avgActivePace:
//            return "lamp.avg_active_pace"
        case .lamp_Activity:
            return "lamp.activity_recognition"
        case .lamp_accelerometer:
            return "lamp.accelerometer"
        case .lamp_device_state:
            return "lamp.device_state"
        }
    }
}
