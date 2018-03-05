//
//  AVIColorPresetsCollectionView.swift
//  sliderMix
//
//  Created by Fede on 11/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import Foundation
import UIKit

class AVIColorPresetsView: UIView {
    
//    @IBOutlet weak var presetsCollectionView:UICollectionView!
//
//    let presets = [UIColor.purple, UIColor.red, UIColor.orange, UIColor.blue, UIColor.green]
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presetCell", for: indexPath) as! AVIColorPresetCell
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        presetsCollectionView.backgroundColor = presets[indexPath.item]
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let nib = UINib(nibName: "AVIColorPresetCell", bundle: Bundle.main)
//        presetsCollectionView.register(nib, forCellWithReuseIdentifier: "presetCell")
//        presetsCollectionView.delegate = self
    }
}

class AVIColorPresetCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var color = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
    
}


