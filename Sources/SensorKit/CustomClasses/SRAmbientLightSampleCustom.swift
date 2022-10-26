//
//  File.swift
//  
//
//  Created by ZCO Engineer on 17/10/22.
//

#if !os(watchOS)
import Foundation
import SensorKit

class SRAmbientLightSampleCustom: Encodable {
    
    var placement: Int
    var chromaticity: SRAmbientLightSampleCustom.ChromaticityCustom
    var lux: Measurement<UnitIlluminance>
    
    init(_ lightSample: SRAmbientLightSample) {
        self.placement = lightSample.placement.rawValue
        self.chromaticity = SRAmbientLightSampleCustom.ChromaticityCustom(lightSample.chromaticity)
        self.lux = lightSample.lux
    }
}

extension SRAmbientLightSampleCustom {
    class ChromaticityCustom: Encodable {
        
        var x: Float32
        var y: Float32
        
        init(_ chromaticity: SRAmbientLightSample.Chromaticity) {
            self.x = chromaticity.x
            self.y = chromaticity.y
        }
    }
}

#endif
