//
//  SettingsViewController.swift
//  Conversion Calculator App
//
//  Created by Shayla Hinkley on 9/25/20.
//  Copyright © 2020 Shayla Hinkley. All rights reserved.
//

import UIKit

//protocol SettingsViewControllerDelegate {
//    func settingsChanged(fromUnits: String, toUnits: String)
//}
class SettingsViewController: UIViewController {
    
    
    
    @IBOutlet weak var fromUnitsValue: UILabel!
    
    @IBOutlet weak var toUnitsValue: UILabel!
    
    @IBOutlet weak var unitsPickerView: UIPickerView!
    
    var lengthPickerData: [String] = [String]()
    var volumePickerData: [String] = [String]()
    var selectionTop: String = "Yards"
    var selectionBottom: String = "Meters"
//    var delegate: SettingsViewControllerDelegate?
    
    var fromOrTo: String = ""
    var currentMode: String = "length"
    var fromUnitsLabel: String?
    var toUnitsLabel: String?
    
    

    override func viewDidLoad() {

        super.viewDidLoad()
        self.setUpfromUnitsValueTap()
        self.setUptoUnitsValueTap()
        self.unitsPickerView.delegate = self
        self.unitsPickerView.dataSource = self
        self.unitsPickerView.isHidden = true

        if let fromLabelSettings = self.fromUnitsLabel {
            self.fromUnitsValue.text = fromLabelSettings
        }
        if let toLabelSettings = self.toUnitsLabel {
            self.toUnitsValue.text = toLabelSettings
        }

        lengthPickerData = ["Yards", "Meters", "Miles"]

        volumePickerData = ["Gallons", "Quarts", "Liters"]

    }
    
    
    func changeMode(input: String) {
        self.currentMode = input
    }
    
    func currentUnits(fromUnit: String, toUnit: String) {
        self.fromUnitsValue.text = fromUnit
        self.toUnitsValue.text = toUnit
    }
    
    //if the from units value is tapped, bring out picker view
    @objc func fromUnitsValueTap(_ sender: UITapGestureRecognizer){
        print("From was tapped")
        self.unitsPickerView.isHidden = false
        self.unitsPickerView.reloadAllComponents()
        self.unitsPickerView.isHidden = false
        whichOne(fromOrToStr: "fromUnits")
    }
    
    //function that tells the program which Label is currently clicked
    func whichOne(fromOrToStr: String){
        fromOrTo = fromOrToStr
    }
    
    //if the to units value is tapped, bring out the picker view
    @objc func toUnitsValueTap(_ sender: UITapGestureRecognizer){
        print("To was tapped")
        self.unitsPickerView.isHidden = false
        self.unitsPickerView.reloadAllComponents()
        self.unitsPickerView.isHidden = false
        whichOne(fromOrToStr: "toUnits")
    }
    
    func setUpfromUnitsValueTap() {
        let fromLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.fromUnitsValueTap(_:)))
        self.fromUnitsValue.isUserInteractionEnabled = true
        self.fromUnitsValue.addGestureRecognizer(fromLabelTap)
    }
    
    func setUptoUnitsValueTap() {
        let toLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.toUnitsValueTap(_:)))
        self.toUnitsValue.isUserInteractionEnabled = true
        self.toUnitsValue.addGestureRecognizer(toLabelTap)
    }
    
    
    @IBAction func entireScreenTapRecognizer(_ sender: UITapGestureRecognizer) {
        self.unitsPickerView.isHidden = true
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToMain", sender: self)

    }
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "segueCancelBackToMain", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSaveBackToMain" {
            if let destVC = segue.destination as? MainViewController {
                destVC.fromUnit = self.fromUnitsValue.text
                destVC.toUnit = self.toUnitsValue.text
            }
        }
    }
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lengthPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentMode == "length" {
             return lengthPickerData[row]
        } else {
            return volumePickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if fromOrTo == "fromUnits" {
            if currentMode == "length" {
                self.selectionTop = lengthPickerData[row]
                fromUnitsValue.text = lengthPickerData[row]
            } else {
                self.selectionTop = volumePickerData[row]
                fromUnitsValue.text = volumePickerData[row]
            }
        } else {
            if currentMode == "length" {
                self.selectionBottom = lengthPickerData[row]
                toUnitsValue.text = lengthPickerData[row]
            } else {
                self.selectionBottom = volumePickerData[row]
                toUnitsValue.text = volumePickerData[row]
            }
        }
    }
    
}
