//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    @IBOutlet weak var leftNumberField: UITextField!
    @IBOutlet weak var rightNumberField: UITextField!
    
    var viewModel = CurrencyConverterViewModel()
    var roubleToUsdRate: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func leftTextFieldChanged(_ sender: Any) {
        let leftText: String? = leftNumberField.text
        guard let leftNumber = Double(leftText ?? "") else {
            return
        }
        rightNumberField.text = String(leftNumber * roubleToUsdRate)
    }
    
}

