//
//  AVIHueSliderView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVIHueSliderView: AVISliderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.minimumValue = 0
        slider.maximumValue = 360
        slider.value = 180 // TODO: read form cloud/device

        textFieldTextColor = UIColor.white
        thumbTitle = "HUE".localizedUppercase
        
        slider.colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1),#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1),#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)].map { $0.cgColor }
        slider.hasGradient = true
        unit = "°"
        
        shadowOnValueText = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedHUE), name: NSNotification.Name("selectedHUENotification"), object: nil)
    }
    
    @objc func getSelectedHUE(notification: Notification) {
        let HUEValue = notification.userInfo?["HUE"] as! CGFloat
        setSliderValue(Float(HUEValue) * 360)
    }
    
    override func didSliderChange(_ value: Float) {
        super.didSliderChange(value)
        let hueValue = value / 360
        NotificationCenter.default.post(name: NSNotification.Name("HUEColorNotification"), object: nil, userInfo: ["HueColor" : CGFloat(hueValue)])
        textFieldBackgroundColor = UIColor(hue: CGFloat(hueValue), saturation: 1, brightness: 1, alpha: 1)
    }
}
