//
//  AVISlider.swift
//  avion
//
//  Created by Fede on 4/1/18.
//  Copyright © 2018 avi-on. All rights reserved.
//

import Foundation
import UIKit

class AVISlider: UISlider {
    @IBInspectable var trackHeight: Float = 0.0
    
    @IBInspectable var minColor:UIColor = UIColor.clear
    @IBInspectable var maxColor:UIColor = UIColor.clear
    
    @IBInspectable var hasGradient = false {
        didSet {
            if hasGradient { setGradient(slider: self, colors: colors) }
            else {
                minimumTrackTintColor = minColor
                maximumTrackTintColor = maxColor
            }
        }
    }
    @IBInspectable var customThumb = true
    var colors: [CGColor] = [UIColor.clear.cgColor]
     
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        super.trackRect(forBounds: bounds)
        let newBounds = CGRect(x: bounds.origin.x, y: (bounds.size.height - CGFloat(trackHeight) ) / 2, width: bounds.size.width, height: CGFloat(trackHeight))
        return newBounds
    }
    
    func setGradient(slider:UISlider, colors:[CGColor]) {
        let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: CGFloat(trackHeight) )
        tgl.frame = frame
        tgl.colors = colors
        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
        tgl.cornerRadius = tgl.frame.size.height / 2
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setMaximumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
        slider.setMinimumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if hasGradient {
            setGradient(slider: self, colors: colors) // redraw the slider gradient
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if hasGradient { setGradient(slider: self, colors: colors) }
        else {
            minimumTrackTintColor = minColor
            maximumTrackTintColor = maxColor
        }
    }
    
    func prepare(minColor: UIColor, maxColor: UIColor, gradient: Bool = false, minValue: Float = 0, maxValue: Float = 1) {
        colors = [minColor.cgColor, maxColor.cgColor]
        hasGradient = gradient
        minimumValue = minValue
        maximumValue = maxValue
    }
}

extension UIImage {
    func strechToWidth(_ width: CGFloat) -> UIImage {
        if (self.size.width == width) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: self.size.height ), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width, height: self.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

