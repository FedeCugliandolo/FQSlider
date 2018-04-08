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
    var color: UIColor
    var selected: Bool
    var name: String
    
    init(original: Bool = false, color: UIColor = UIColor.clear, selected: Bool = false, name: String = "") {
        self.original = original
        self.color = color
        self.selected = selected
        self.name = name
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AVIColorPresetCellDelegate {
    @IBOutlet weak var presetsCollectionView:UICollectionView!
    
    let defaultPresets = [Preset(original: true, color: #colorLiteral(red: 0.7960784314, green: 1, blue: 0, alpha: 1), selected: false, name: "Relax"),
                          Preset(original: true, color: #colorLiteral(red: 0.007843137255, green: 0.831372549, blue: 1, alpha: 1), selected: false, name: "Focus"),
                          Preset(original: true, color: #colorLiteral(red: 0.9960784314, green: 0.7490196078, blue: 0.1333333333, alpha: 1), selected: false, name: "Sunrise"),
                          Preset(original: true, color: #colorLiteral(red: 1, green: 0.2196078431, blue: 0, alpha: 1), selected: false, name: "Romantic"),
                          Preset(original: true, color: #colorLiteral(red: 0.8745098039, green: 0.1607843137, blue: 0.9725490196, alpha: 1), selected: false, name: "Party"),
                          Preset(original: true, color: #colorLiteral(red: 0.3137254902, green: 0.8901960784, blue: 0.7607843137, alpha: 1), selected: false, name: "Aqua")]
    
    var totalPresets = [Preset]()
    
    // MARK: - Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalPresets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presetCell", for: indexPath) as! AVIColorPresetCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let presetCell = cell as? AVIColorPresetCell {
            presetCell.delegate = self
            presetCell.preset = totalPresets[indexPath.item]
            presetCell.backgroundColor = presetCell.preset.color
            presetCell.nameLabel?.text = presetCell.preset.name.uppercased()
            presetCell.selectedImageView.isHidden = !presetCell.preset.selected
            presetCell.deleteButton.isHidden = presetCell.preset.original
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let presetCell = collectionView.cellForItem(at: indexPath) as? AVIColorPresetCell {
            presetCell.selectedImageView.isHidden = true
            presetCell.preset.selected = false
        }
    }
    
    func unselectAllPresets() {
        totalPresets.forEach { $0.selected = false }
        presetsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let presetCell = collectionView.cellForItem(at: indexPath) as? AVIColorPresetCell {
            
            unselectAllPresets()
            
            presetCell.selectedImageView.isHidden = false
            presetCell.preset.selected = true
            
            finalColor = presetCell.preset.color
            // get color's components
            var hue        : CGFloat = 0
            var saturation : CGFloat = 0
            var brightness : CGFloat = 0
            var alpha      : CGFloat = 0
            if finalColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                NotificationCenter.default.post(name: NSNotification.Name("selectedSATNotification"), object: nil, userInfo: ["SAT" : saturation])
                NotificationCenter.default.post(name: NSNotification.Name("selectedHUENotification"), object: nil, userInfo: ["HUE" : hue])
            }
            NotificationCenter.default.post(name: NSNotification.Name("selectedPresetColorNotification"), object: nil, userInfo: ["finalColor" : finalColor])
        }
    }
    
    // MARK: - Actions
    
    @IBAction func savePresetAction(_ sender: Any) {
        let alert = UIAlertController(title: "Save New Preset?", message: "Please enter the name for the new Preset:", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "i.e. Afternoon"
        }
        alert.addAction(UIAlertAction(title: "Ok".localizedCapitalized, style: UIAlertActionStyle.default, handler: { (alertAction) in
            // TODO: verificar que tenga nombre
            self.unselectAllPresets()
            let newPreset = Preset(original: false, color: self.finalColor, selected: true, name: alert.textFields![0].text!)
            self.totalPresets.insert(newPreset, at: 0)
            self.presetsCollectionView.setContentOffset(CGPoint.zero, animated: true)
            self.presetsCollectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            print("CANCEL")
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presetsCollectionView.delegate = self
        presetsCollectionView.dataSource = self
        presetsCollectionView.backgroundColor = UIColor.clear
        let nib = UINib(nibName: "AVIColorPresetCell", bundle: Bundle.main)
        presetsCollectionView.register(nib, forCellWithReuseIdentifier: "presetCell")
        totalPresets = defaultPresets
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCurrentColor), name: NSNotification.Name("finalColorNotification"), object: nil)
    }
    
    var finalColor = UIColor.clear
    @objc func getCurrentColor (notification: Notification) {
        finalColor = notification.userInfo?["finalColor"] as? UIColor ?? UIColor.clear
    }
    
    // Preset cell delegates
    func didTapDeleteButton(preset: Preset) {
        let deleteAlert = UIAlertController(title: "Delete Preset?", message: preset.name, preferredStyle: UIAlertControllerStyle.alert)
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { alertAction in
            if let index = self.totalPresets.index(where: { $0 === preset}) {
                self.totalPresets.remove(at: index)
                self.presetsCollectionView.reloadData()
            }
        }))
        self.present(deleteAlert, animated: true, completion: nil)
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
