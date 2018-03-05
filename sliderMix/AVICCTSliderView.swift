//
//  AVIWhiteSliderView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVICCTSliderView: AVISliderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        let cctColor1 = #colorLiteral(red: 1, green: 0.8470588235, blue: 0.537254902, alpha: 1)
        let cctColor2 = #colorLiteral(red: 1, green: 0.9843137255, blue: 0.7921568627, alpha: 1)
        let cctColor3 = #colorLiteral(red: 0.7137254902, green: 0.8980392157, blue: 1, alpha: 1)
        slider.colors = [cctColor1.cgColor, cctColor2.cgColor, cctColor3.cgColor]
        slider.hasGradient = true
        thumbTitle = "CCT"
    }
}
