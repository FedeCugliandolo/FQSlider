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
    }
    
    @IBOutlet weak var currentSettingsTitleLablel: UILabel! {
        didSet {
            currentSettingsTitleLablel.text = "CURRENT SETTINGS"
        }
    }
    var currentColor = UIColor()
    
    @objc func getCurrentColor (notification: Notification) {
        backgroundColor = notification.userInfo?["finalColor"] as? UIColor
    }
}
