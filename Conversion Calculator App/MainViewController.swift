
//  ViewController.swift
//  Conversion Calculator App
//
//  Created by Shayla Hinkley on 9/25/20.
//  Copyright © 2020 Shayla Hinkley. All rights reserved.
//

import UIKit

//protocol MainViewControllerDelegate {
//    func changeMode(input: String)
//    func currentUnits(fromUnits: String, toUnits: String)
//}
class MainViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lengthTopEnterValue: DecimalMinusTextField!
    
    @IBOutlet weak var lengthBottomEnterValue: DecimalMinusTextField!
    
    @IBOutlet weak var fromUnitLabel: UILabel!
    @IBOutlet weak var toUnitLabel: UILabel!
    
    var fromUnit: String?
    var toUnit: String?
  //  var delegate: MainViewControllerDelegate?
    var mode: String = "length"
    var currentFromUnit: String = "Yards"
    var currentToUnit: String = "Meters"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lengthTopEnterValue.delegate = self
        self.lengthBottomEnterValue.delegate = self
        self.fromUnitLabel.text = currentFromUnit
        self.toUnitLabel.text = currentToUnit
        if let fromLabel = self.fromUnit {
            self.fromUnitLabel.text = fromLabel
        }
        if let toLabel = self.toUnit {
            self.toUnitLabel.text = toLabel
        }
    }
    
  
//    override func viewWillDisappear(_ animated: Bool) {
//           super.viewWillDisappear(animated)
//           if let d = self.delegate {
//            d.changeMode(input: mode)
//            d.currentUnits(fromUnits: currentFromUnit, toUnits: currentToUnit)
//           }
//       }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }
    func settingsChanged(fromUnits: String, toUnits: String) {
        self.fromUnitLabel.text = fromUnits
        self.toUnitLabel.text = toUnits
        currentFromUnit = fromUnits
        currentToUnit = toUnits
    }
  
    
    func calcYardToMeters(yards: String) -> String {
        var numMeters: Double
        numMeters = Double(yards)! * 0.9144
        return String(numMeters)
    }
    
    func calcMeterToYards(meters: String) -> String {
        var numYards: Double
        numYards = Double(meters)! * 1.0936133
        return String (numYards)
    }


    @IBAction func calculateButtonPressed(_ sender: Any) {
        if lengthTopEnterValue.text! != "" {
            lengthBottomEnterValue.text! = calcYardToMeters(yards: lengthTopEnterValue.text!)
            
        }
        if lengthBottomEnterValue.text! != "" {
            lengthTopEnterValue.text! = calcMeterToYards(meters: lengthBottomEnterValue.text!)
        }
        self.view.endEditing(true)
        
    }
    @IBAction func clearButtonPressed(_ sender: Any) {
        lengthBottomEnterValue.text = nil
        lengthTopEnterValue.text = nil
        self.view.endEditing(true)
    }
    @IBAction func dismissKeyBoardTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToSettings", sender: self)
    }
    
    @IBAction func modeButtonPressed(_ sender: UIButton) {
        if titleLabel.text == "Length Conversion Calculator" {
            titleLabel.text = "Volume Conversion Calculator"
            fromUnitLabel.text = "Gallons"
            toUnitLabel.text = "Liters"
            mode = "volume"
        } else {
            titleLabel.text = "Length Conversion Calculator"
            fromUnitLabel.text = "Yards"
            toUnitLabel.text = "Meters"
            mode = "length"
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSettings" {
            let destVC = segue.destination as? SettingsViewController
                destVC?.toUnitsLabel = self.toUnitLabel.text
                destVC?.fromUnitsLabel = self.fromUnitLabel.text
            }
        }
    }


extension MainViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.lengthTopEnterValue {
            lengthBottomEnterValue.text = nil
        } else {
            lengthTopEnterValue.text = nil
        }
    }
    
    
}





