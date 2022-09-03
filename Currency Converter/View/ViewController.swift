//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var updateTimeButton: UIButton!
    @IBOutlet private weak var changeButton: UIButton!
    @IBOutlet private weak var leftNumberField: UITextField!
    @IBOutlet private weak var rightNumberField: UITextField!
    
    var viewModel = CurrencyConverterViewModel()
    var roubleToUsdRate: Double = 0
    var usdToRoubleRate: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: updateButton)
        setupButton(button: updateTimeButton)
        setupButton(button: changeButton)
    }

    @IBAction func leftTextFieldChanged(_ sender: Any) {
        roubleToUsdRate = viewModel.getCurrentRoubleToUSDRate()
        let leftText: String? = leftNumberField.text
        guard let leftNumber = Double(leftText ?? "") else {
            return
        }
        rightNumberField.text = String(leftNumber * roubleToUsdRate)
    }

    @IBAction func rightTextFieldChange(_ sender: Any) {
        roubleToUsdRate = viewModel.getCurrentUsdToRoubleRate()
        let rightText: String? = rightNumberField.text
        guard let rightNumber = Double(rightText ?? "") else {
            return
        }
        leftNumberField.text = String(rightNumber * roubleToUsdRate)
    }

    private func setupButton(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }

}

