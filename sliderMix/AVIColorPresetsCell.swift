//
//  AVIColorPresetsCollectionView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

protocol AVIColorPresetCellDelegate {
    func didTapDeleteButton(preset: Preset)
}

class AVIColorPresetCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var HUEColorView: UIView!
    var delegate: AVIColorPresetCellDelegate?
    
    var preset = Preset()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        HUEColorView.layer.cornerRadius = 8
        
        nameLabel.textColor = UIColor.white
        nameLabel.font = AppFont.Bold.of(size: 11) // TODO: multipler for iPad
        nameLabel.layer.addShadow()
    }
    
    @IBAction func deletePresetAction(_ sender: Any) {
        delegate?.didTapDeleteButton(preset: self.preset)
    }
    
}

extension CALayer {
    func addShadow(color : UIColor = UIColor.gray, radius: CGFloat = 2, offset: CGSize = CGSize(width: 1, height: 1), opacity: Float = 1) {
        self.shadowColor = color.cgColor
        self.shadowRadius = radius
        self.shadowOffset = offset
        self.shadowOpacity = opacity
        self.masksToBounds = false
    }
}


