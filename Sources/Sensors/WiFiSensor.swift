#if !os(watchOS)

import NetworkExtension
import SystemConfiguration.CaptiveNetwork


public class WiFiDeviceData {

    public var macAddress: String?
    public var bssid: String?
    public var ssid: String?

}

public class WiFiScanData {
    
    public var timestamp = Date().timeIntervalSince1970 * 1000
    public var bssid: String = ""
    public var ssid: String  = ""
    
    public var security: String = ""
    public var frequency: Int = 0
    public var rssi: Int = 0
}

public protocol WiFiObserver: class {
    func onWiFiAPDetected(data: WiFiScanData)
    func onWiFiDisabled()
    func onWiFiScanStarted()
    func onWiFiScanEnded()
}

public class WiFiSensor: ISensorController {

    public var CONFIG = Config()
    let reachability: Reachability

    public class Config: SensorConfig {
      
        public weak var sensorObserver: WiFiObserver?

        public override init() {
            super.init()
        }
        
        public func apply(closure:(_ config: WiFiSensor.Config) -> Void) -> Self {
            closure(self)
            return self
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
        }
    }
    
    public convenience init(){
        self.init(WiFiSensor.Config())
    }
    
    public init(_ config: WiFiSensor.Config){
        CONFIG = config
        reachability = try! Reachability()
    }
    public func start() {
    }
    
    public func stop() {
    }
    
    public func stopScanning() {
        
        reachability.stopNotifier()
    }
    
    public func startScanning() {
        if self.reachability.connection == .wifi {
            let networkInfos = self.getNetworkInfos()
            
            for info in networkInfos{
                // send a WiFiScanData via observer
                let scanData = WiFiScanData.init()
                //scanData.label = self.CONFIG.label
                scanData.ssid = info.ssid
                scanData.bssid = info.bssid

                if let wifiObserver = self.CONFIG.sensorObserver {
                    wifiObserver.onWiFiAPDetected(data: scanData)
                }
            }
        }
        
        // start WiFi reachability/unreachable monitoring
        do{
            // reachable events
            reachability.whenReachable = { reachability in
                switch reachability.connection {
                case .wifi:
                    let networkInfos = self.getNetworkInfos()
                    for info in networkInfos{
                        // send a WiFiScanData via observer
                        let scanData = WiFiScanData.init()
                        //scanData.label = self.CONFIG.label
                        scanData.ssid = info.ssid
                        scanData.bssid = info.bssid
                        if let observer = self.CONFIG.sensorObserver {
                            observer.onWiFiAPDetected(data: scanData)
                        }
                        
                    }
                    
                    break
                case .cellular, .none:
                    if let observer = self.CONFIG.sensorObserver {
                        observer.onWiFiDisabled()
                    }
                    break
                case .unavailable:
                    break
                }
            }
            try reachability.startNotifier()
        } catch {
            print("WiFiSensor \(error)")
        }
    }
    
    struct NetworkInfo {
        public let interface:String
        public let ssid:String
        public let bssid:String
        init(_ interface:String, _ ssid:String,_ bssid:String) {
            self.interface = interface
            self.ssid = ssid
            self.bssid = bssid
        }
    }

    func getNetworkInfos() -> Array<NetworkInfo> {
        // https://forums.developer.apple.com/thread/50302
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return []
        }
        let networkInfos:[NetworkInfo] = interfaceNames.compactMap{ name in
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String:AnyObject] else {
                return nil
            }
            guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                return nil
            }
            guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
                return nil
            }
            return NetworkInfo(name, ssid,bssid)
        }
        return networkInfos
    }

}

#endif