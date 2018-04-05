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
        
        nameLabel.textColor = UIColor.white
        nameLabel.font = FontBook.Bold.of(size: 11) // TODO: multipler for iPad
        nameLabel.addShadow()
    }
    
}

extension UILabel {
    func addShadow(color : UIColor = UIColor.gray, radius: CGFloat = 2, offset: CGSize = CGSize(width: 1, height: 1), opacity: Float = 1) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}


