//
//  ViewController.swift
//  sliderMix
//
//  Created by Fede on 8/1/18.
//  Copyright © 2018 Fede. All rights reserved.
//

import UIKit

class Preset
{
    var original: Bool
    var color = UIColor.clear
    var selected = false
    var name: String
    
    init(original: Bool, color: UIColor, selected: Bool, name: String) {
        self.original = original
        self.color = color
        self.selected = selected
        self.name = name
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var presetsCollectionView:UICollectionView!
    
    let defaultPresets = [Preset(original: true, color: #colorLiteral(red: 0.7960784314, green: 1, blue: 0, alpha: 1), selected: false, name: "Relax"),
                          Preset(original: true, color: #colorLiteral(red: 0.007843137255, green: 0.831372549, blue: 1, alpha: 1), selected: false, name: "Focus"),
                          Preset(original: true, color: #colorLiteral(red: 0.9960784314, green: 0.7490196078, blue: 0.1333333333, alpha: 1), selected: false, name: "Sunrise"),
                          Preset(original: true, color: #colorLiteral(red: 1, green: 0.2196078431, blue: 0, alpha: 1), selected: false, name: "Romantic"),
                          Preset(original: true, color: #colorLiteral(red: 0.8745098039, green: 0.1607843137, blue: 0.9725490196, alpha: 1), selected: false, name: "Party")]
    
    let totalPresets = [Preset]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultPresets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presetCell", for: indexPath) as! AVIColorPresetCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = defaultPresets[indexPath.item].color
        if let presetCell = cell as? AVIColorPresetCell {
            presetCell.nameLabel?.text = defaultPresets[indexPath.item].name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presetsCollectionView.delegate = self
        presetsCollectionView.dataSource = self
        presetsCollectionView.backgroundColor = UIColor.clear
        let nib = UINib(nibName: "AVIColorPresetCell", bundle: Bundle.main)
        presetsCollectionView.register(nib, forCellWithReuseIdentifier: "presetCell")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
