//
//  AVICurrentColorView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVICurrentColorView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        NotificationCenter.default.addObserver(self, selector: #selector(getCurrentColor), name: NSNotification.Name("finalColorNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getCurrentColor), name: NSNotification.Name("selectedPresetColorNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getCCTColor), name: NSNotification.Name("CCTColorNotification"), object: nil)
    }
    
    @IBOutlet weak var HUEColorView: UIView!
    
    @IBOutlet weak var currentSettingsTitleLablel: UILabel! {
        didSet {
            currentSettingsTitleLablel.text = "CURRENT SETTINGS"
            currentSettingsTitleLablel.font = AppFont.Bold.of(size: 14) // TODO: multiplier iPad
            currentSettingsTitleLablel.layer.addShadow()
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle("SAVE", for: .normal)
            saveButton.titleLabel?.font = AppFont.Bold.of(size: 14)
            saveButton.titleLabel?.layer.addShadow()
            saveButton.imageView?.layer.addShadow()
            let spacing: CGFloat = 5
            saveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
            saveButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
            saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        }
    }
    
    var currentColor = UIColor()
    
    @objc func getCurrentColor (notification: Notification) {
        HUEColorView.backgroundColor = notification.userInfo?["finalColor"] as? UIColor
    }
    
    @objc func getCCTColor(notification: Notification) {
        backgroundColor = UIColor.getCCTColorFrom(value: notification.userInfo?["CCTValue"] as! Float)
    }
}
