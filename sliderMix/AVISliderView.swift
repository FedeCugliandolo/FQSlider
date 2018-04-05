//
//  AVISliderView.swift
//  avion
//
//  Created by Fede on 5/1/18.
//  Copyright © 2018 avi-on. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AVISliderView: UIView, UITextFieldDelegate {
    @IBOutlet var mainView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("AVISliderView", owner: self, options: nil)
        addSubview(mainView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbView.isUserInteractionEnabled = false
        valueTextField.textAlignment = .center
        valueTextField.delegate = self
        if customThumb { slider.setThumbImage(UIImage(named:"clearImage"), for: .normal) }
        thumbView.isHidden = !customThumb
        valueTextField.text = String(Int(slider.value))

        let tapOnSliderGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapOnSlider))
        tapOnSliderGesture.minimumPressDuration = 0
        sliderViewContainer.addGestureRecognizer(tapOnSliderGesture)
        
        // observers
        NotificationCenter.default.addObserver(self, selector: #selector(getHUE), name: NSNotification.Name("HUEColorNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getSAT), name: NSNotification.Name("SatColorNotification"), object: nil)
    }
    
    @objc private func getHUE(notification: Notification) {
        finalColor.HUE = notification.userInfo?["HueColor"] as! CGFloat
    }
    
    @objc private func getSAT(notification: Notification) {
        finalColor.SAT = notification.userInfo?["SatColor"] as! CGFloat
    }
    
    // MARK: - Slider
    @IBInspectable var customThumb: Bool { return true }
    
    var thumbTitle = String() {
        didSet {
            let attributedString = NSMutableAttributedString(string: thumbTitle)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSRange(location: 0, length: attributedString.length - 1))
            sliderTitleView.attributedText = attributedString
        }
    }
    
    @IBOutlet weak var sliderTitleView: UITextField!
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var sliderViewContainer: UIView!
    @IBOutlet weak var slider: AVISlider!
    @IBOutlet weak var valueTextField: UITextField! {
        didSet {
            valueTextField.backgroundColor = textFieldBackgroundColor
            valueTextField.font = FontBook.Regular.of(size: 20)
            valueTextField.textColor = textFieldTextColor
        }
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        setSliderValue(sender.value)
    }
    
    func didSliderChange(_ value: Float) {
        valueTextField.text = String(Int(value)) + " " + unit
    }
    
    func setSliderValue(_ value: Float) {
        slider.setValue(value, animated: true)
        setIndicatorFrame()
        didSliderChange(slider.value)
    }
    

    // MARK: - TextField Delegates
    var unit = "%"
    
    var textFieldBackgroundColor = UIColor(red: 237/255,
                                           green: 242/255,
                                           blue: 247/255,
                                           alpha: 1) {
        didSet {
            valueTextField.backgroundColor = textFieldBackgroundColor
        }
    }
    
    var textFieldTextColor = UIColor(red: 101/255, green: 109/255, blue: 122/255, alpha: 1) {
        didSet {
            valueTextField.textColor = textFieldTextColor
        }
    }
        
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard !(textField.text?.isEmpty)! else { return false }
        setSliderValue((textField.text! as NSString).floatValue)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = textField.text!.numbers
        let complete = Int(current + string)
        return complete! <= Int(slider.maximumValue) && complete! >= Int(slider.minimumValue)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = textField.text?.numbers
        return true
    }
    
    // move the custom thumb
    func setIndicatorFrame() {
        let trackRect = slider.trackRect(forBounds: slider.bounds)
        let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: slider.value)
        
        var indicatorFrame = thumbView.frame
        let rest = (indicatorFrame.size.width - thumbRect.size.width) / 2
        let origin = thumbRect.origin.x + slider.frame.origin.x
        indicatorFrame.origin.x = origin - rest
        thumbView.frame = indicatorFrame
    }
    
    // MARK: -  Gestures: Long tap for slider
    @objc func tapOnSlider(tap: UITapGestureRecognizer) {
        guard !slider.isHighlighted else { return }
        
        let tapPoint = tap.location(in: sliderViewContainer)
        let value = tapPoint.x / slider.bounds.size.width
        var denormalizedValue = Float(value) * (slider.maximumValue - slider.minimumValue) + slider.minimumValue
        
        if denormalizedValue < slider.minimumValue {
            denormalizedValue = slider.minimumValue
        }
        if denormalizedValue > slider.maximumValue {
            denormalizedValue = slider.maximumValue
        }
        
        setSliderValue(denormalizedValue)
    }
    
    struct FinalColor {
        var HUE: CGFloat
        var SAT: CGFloat
    }
    
    var finalColor = FinalColor(HUE: 0.5, SAT: 0.5) {
        didSet {
            let color = UIColor(hue: finalColor.HUE, saturation: finalColor.SAT, brightness: 1, alpha: 1)
            NotificationCenter.default.post(name: NSNotification.Name("finalColorNotification"), object: nil, userInfo: ["finalColor" : color])
        }
    }
}

enum FontBook: String {
    case Regular = "HelveticaNeue"
    case Thin = "HelveticaNeue-Thin"
    case Bold = "HelveticaNeue-Bold"
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

extension String {
    var numbers: String {
        return String(describing: filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil })
    }
}

