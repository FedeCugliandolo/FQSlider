//
//  AVIDimSlider.swift
//  sliderMix
//
//  Created by Fede on 9/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVIDimSliderView: AVISliderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.minColor = #colorLiteral(red: 0.3960784314, green: 0.4274509804, blue: 0.4784313725, alpha: 1)
        slider.maxColor = #colorLiteral(red: 0.8666666667, green: 0.8901960784, blue: 0.9137254902, alpha: 1)
        slider.colors = [slider.minColor.cgColor, slider.maxColor.cgColor]
        slider.hasGradient = false
        thumbTitle = "DIM".localizedUppercase
        clearSelectedPresets = false
    }
}
