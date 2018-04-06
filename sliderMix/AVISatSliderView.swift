//
//  AVISatSliderView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVISatSliderView: AVISliderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50 // TODO: read fromm cloud/device
        slider.prepare(minColor: UIColor.white, maxColor: UIColor.purple, gradient: true)
        thumbTitle = "SAT".localizedUppercase
        
        NotificationCenter.default.addObserver(self, selector: #selector(getHueForSat), name: NSNotification.Name("HUEColorNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedSAT), name: NSNotification.Name("selectedSATNotification"), object: nil)
    }
    
    @objc func getSelectedSAT(notification: Notification) {
        let SATValue = notification.userInfo?["SAT"] as! CGFloat
        setSliderValue(Float(SATValue) * 100)
    }
    
    @objc func getHueForSat(notification: Notification) {
        let satColor = UIColor(hue: notification.userInfo?["HueColor"] as! CGFloat, saturation: 1, brightness: 1, alpha: 1)
        slider.prepare(minColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), maxColor: satColor, gradient: true)
    }
    
    override func didSliderChange(_ value: Float) {
        super.didSliderChange(value) // show textfield percentage
        NotificationCenter.default.post(name: NSNotification.Name("SatColorNotification"), object: nil, userInfo: ["SatColor" : CGFloat(value/100)])
    }
}
