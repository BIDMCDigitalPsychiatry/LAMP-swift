#if !os(watchOS)

import Reachability

import NetworkExtension
import SystemConfiguration.CaptiveNetwork


public class WiFiDeviceData {

    public var macAddress: String?
    public var bssid: String?
    public var ssid: String?

}

public protocol WiFiObserver: class {
    func onWiFiAPDetected(data: WiFiScanData)
    func onWiFiDisabled()
    func onWiFiScanStarted()
    func onWiFiScanEnded()
}

public class WiFiSensor: ISensorController {

    public var identifier = "WiFiSensor"
    public var config = Config()
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
        self.config = config
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

                if let wifiObserver = self.config.sensorObserver {
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
                        if let observer = self.config.sensorObserver {
                            observer.onWiFiAPDetected(data: scanData)
                        }
                        
                    }
                    
                    break
                case .cellular, .none:
                    if let observer = self.config.sensorObserver {
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
