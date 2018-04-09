//
//  AVIWhiteSliderView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

private let cctColor1 = #colorLiteral(red: 1, green: 0.8470588235, blue: 0.537254902, alpha: 1)
private let cctColor2 = #colorLiteral(red: 1, green: 0.9843137255, blue: 0.7921568627, alpha: 1)
private let cctColor3 = #colorLiteral(red: 0.7137254902, green: 0.8980392157, blue: 1, alpha: 1)
private let cctMaxValue:Float = 6500
private let cctMinValue:Float = 2700

class AVICCTSliderView: AVISliderView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.colors = [cctColor1.cgColor, cctColor2.cgColor, cctColor3.cgColor]
        slider.hasGradient = true
        thumbTitle = "CCT".localizedUppercase
        unit = "k"
        slider.minimumValue = cctMinValue
        slider.maximumValue = cctMaxValue
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedCCT), name: NSNotification.Name("selectedCCTNotification"), object: nil)
    }

    @objc func getSelectedCCT(notification: Notification) {
        let CCTValue = notification.userInfo?["CCT"] as! Float
        setSliderValue(CCTValue)
    }
    
    override func didSliderChange(_ value: Float) {
        super.didSliderChange(value)
        NotificationCenter.default.post(name: NSNotification.Name("CCTColorNotification"), object: nil, userInfo: ["CCTValue" :  value])
        textFieldBackgroundColor = UIColor.getCCTColorFrom(value: value)
    }
}

extension UIColor {
    @objc class func getCCTColorFrom(value: Float) -> UIColor {
        let percent = (value - cctMinValue) * 100 / (cctMaxValue - cctMinValue)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if percent < 50 {
            cctColor1.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(1 - percent/50))
        } else {
            cctColor3.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(((percent - 50) * 2) / 100))
        }
    }
}
