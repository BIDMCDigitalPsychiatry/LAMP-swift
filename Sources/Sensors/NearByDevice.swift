//
//  File.swift
//  
//
//  Created by Jijo Pulikkottil on 04/12/23.
//

import Foundation

public class NearByDevice: NSObject, ISensorController {
    
    var timer: Timer?
    public var config: NearByDevice.Config
    let queue = DispatchQueue(label: "NearByDeviceSensor", qos: .background, attributes: .concurrent)
    
    var latestBluetoothdata: [LMBluetoothData] = []
    var latestWifidata: [WiFiScanData] = []
    
    
    var bluetoothSensor: LMBluetoothSensor?
    #if os(iOS)
    var wifiSensor: WiFiSensor?
    #endif
    
    public convenience override init() {
        self.init(NearByDevice.Config())
    }
    
    public init(_ config: NearByDevice.Config){
        self.config = config
    }
    
    public func start() {
        
        queue.async {
            let currentRunLoop = RunLoop.current
            self.timer?.invalidate()
            self.timer = nil
            self.timer = Timer.scheduledTimer(timeInterval: self.config.minimumInterval, target: self, selector: #selector(self.fetchDeviceData), userInfo: nil, repeats: true)
            currentRunLoop.add(self.timer!, forMode: .common)
            currentRunLoop.run()
        }
#if os(iOS)
        wifiSensor = WiFiSensor()
#endif
        bluetoothSensor = LMBluetoothSensor()
    }
    
    public func stop() {
#if os(iOS)
        wifiSensor?.stop()
#endif
        bluetoothSensor?.stop()
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func fetchDeviceData() {
        
#if os(iOS)
        wifiSensor?.sensorObserver = self
        wifiSensor?.start()
#endif
        bluetoothSensor?.sensorObserver = self
        bluetoothSensor?.start()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 15) { [weak self] in
#if os(iOS)
            self?.wifiSensor?.stop()
#endif
            self?.bluetoothSensor?.stop()
        }
        
    }
    
    public func latestBluetoothData() -> [LMBluetoothData]? {
        let data = latestBluetoothdata
        latestBluetoothdata = []
        return data
    }
    
    public func latestWifiData() -> [WiFiScanData]? {
        let data = latestWifidata
        latestWifidata = []
        return data
    }
    
    
    public class Config: SensorConfig {
        
        var minimumInterval: Double {
            guard let frquecySetByUser = activeFrequency, frquecySetByUser > 0.0 else { return 300 } 
            return 1.0 / frquecySetByUser
        }
        var activeFrequency: Double?
        public var frequency: Double? = nil { // Hz
            didSet {
                guard let frquenctValue = frequency, frquenctValue > 0.0 else { return }
                activeFrequency = min(frquenctValue, 1/300.0)
            }
        }
      
        public override init() {
            super.init()
        }
        
        public func apply(closure:(_ config: NearByDevice.Config) -> Void) -> Self {
            closure(self)
            return self
        }
        
        public override func set(config: Dictionary<String, Any>) {
            super.set(config: config)
        }
    }
}
#if os(iOS)
extension NearByDevice: WiFiObserver {

    public func onWiFiAPDetected(data: [WiFiScanData]) {
        latestWifidata.append(contentsOf: data)
    }
}
#endif
extension NearByDevice: LMBluetoothSensorDelegate {
    public func onBluetoothDetected(data: LMBluetoothData) {
        latestBluetoothdata.append(data)
    }
}
