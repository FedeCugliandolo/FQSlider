//
//  AVIColorPresetsCollectionView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVIColorPresetCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
}


