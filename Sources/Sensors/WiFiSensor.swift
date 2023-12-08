#if !os(watchOS)

import NetworkExtension
import SystemConfiguration.CaptiveNetwork


public class WiFiDeviceData {

    public var macAddress: String?
    public var bssid: String?
    public var ssid: String?

}

public protocol WiFiObserver: AnyObject {
    func onWiFiAPDetected(data: [WiFiScanData])
//    func onWiFiDisabled()
////    func onWiFiScanStarted()
//    func onWiFiScanEnded()
}

public class WiFiSensor: ISensorController {

    public var identifier = "WiFiSensor"
    //let reachability: Reachability
    //public var arrDiscoveredDevices = [WiFiScanData]()
    public weak var sensorObserver: WiFiObserver?

    public init(){
        //reachability = try! Reachability()
    }
    public func start() {
        startScanning()
    }
    
    public func stop() {
        sensorObserver = nil
        stopScanning()
    }
    
    public func stopScanning() {
        
        //reachability.stopNotifier()
    }
    
    public func startScanning() {
        
        let networkInfos = self.getNetworkInfos()
        
        let scandata = networkInfos.map { info in
            var scanDatum = WiFiScanData.init()
            scanDatum.ssid = info.ssid
            scanDatum.bssid = info.bssid
            return scanDatum
        }
        if let observer = self.sensorObserver {
            observer.onWiFiAPDetected(data: scandata)
        }
        
//        if self.reachability.connection == .wifi {
//            let networkInfos = self.getNetworkInfos()
//            
//            let scandata = networkInfos.map { info in
//                var scanDatum = WiFiScanData.init()
//                scanDatum.ssid = info.ssid
//                scanDatum.bssid = info.bssid
//                return scanDatum
//            }
//            if let observer = self.sensorObserver {
//                observer.onWiFiAPDetected(data: scandata)
//            }
//        }
//        
        // start WiFi reachability/unreachable monitoring
//        do{
//            // reachable events
//            reachability.whenReachable = { [weak self] reachability in
//                switch reachability.connection {
//                case .wifi:
//                    guard let networkInfos = self?.getNetworkInfos() else {
//                        self?.sensorObserver?.onWiFiScanEnded()
//                        return
//                    }
//                    
//                    let scandata = networkInfos.map { info in
//                        var scanDatum = WiFiScanData.init()
//                        scanDatum.ssid = info.ssid
//                        scanDatum.bssid = info.bssid
//                        return scanDatum
//                    }
//                    if let observer = self?.sensorObserver {
//                        observer.onWiFiAPDetected(data: scandata)
//                    }
//                    break
//                case .cellular:
//                    if let observer = self?.sensorObserver {
//                        observer.onWiFiDisabled()
//                    }
//                    break
//                case .unavailable:
//                    break
//                }
//            }
//            try reachability.startNotifier()
//        } catch {
//            print("WiFiSensor \(error)")
//        }
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
