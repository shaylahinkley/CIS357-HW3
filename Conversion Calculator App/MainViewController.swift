
//  ViewController.swift
//  Conversion Calculator App
//
//  Created by Shayla Hinkley on 9/25/20.
//  Copyright © 2020 Shayla Hinkley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var lengthTopEnterValue: DecimalMinusTextField!
    
    @IBOutlet weak var lengthBottomEnterValue: DecimalMinusTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lengthTopEnterValue.delegate = self
        self.lengthBottomEnterValue.delegate = self
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
    
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        
       return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.lengthTopEnterValue) {
            lengthBottomEnterValue.text = nil
        } else {
            lengthTopEnterValue.text = nil
        }
    }
    
    
}





