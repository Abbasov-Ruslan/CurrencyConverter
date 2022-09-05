//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import UIKit
import Combine

enum ExchnageDirection {
    case leftToRight
    case rightToLeft
}

class CurrencyMainViewController: UIViewController {

    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var updateTimeButton: UIButton!
    @IBOutlet private weak var leftCurrencyButton: UIButton!
    @IBOutlet private weak var rightCurrecnyButon: UIButton!
    @IBOutlet private weak var leftNumberField: UITextField!
    @IBOutlet private weak var rightNumberField: UITextField!
    
    var viewModel = CurrencyConverterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: updateButton)
        setupButton(button: updateTimeButton)
        setupButton(button: leftCurrencyButton)
        setupButton(button: rightCurrecnyButon)

    }

    @IBAction func leftTextFieldChange(_ sender: Any) {
        rightNumberField.text = getAssociatedTextFieldNumString(numberText: leftNumberField.text,
                                                                exchangeDirection: .leftToRight)
    }

    @IBAction func rightTextFieldChange(_ sender: Any) {
        leftNumberField.text = getAssociatedTextFieldNumString(numberText: rightNumberField.text,
                                                               exchangeDirection: .rightToLeft)
    }
    @IBAction func leftCurrencyChangeButtonPress(_ sender: Any) {
        viewModel.currentCurrencyForChange = .leftToRight
        performSegue(withIdentifier: "showCurrencyList", sender: nil)
    }
    @IBAction func rightCurrencyChangeButtonPress(_ sender: Any) {
        viewModel.currentCurrencyForChange = .rightToLeft
        performSegue(withIdentifier: "showCurrencyList", sender: nil)
    }

    @IBAction func updateButtonPress(_ sender: Any) {
        viewModel.updateCurrencyRate()
    }

    @IBAction func changeTimePeriodButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "showTimeChageList", sender: nil)
    }


    private func setupButton(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }

    private func getAssociatedTextFieldNumString(numberText: String?,
                                                 exchangeDirection: ExchnageDirection) -> String {
        guard let text = numberText, let number = Double(text) else {
            return ""
        }

        var resultString = ""

        switch exchangeDirection {
        case .leftToRight:
            resultString = viewModel.getExchangeResultAmountString(
                from: viewModel.currentFirstCurrency,
                to: viewModel.currentSecondCurrecny,
                currencyAmount: number)

        case .rightToLeft:
            resultString = viewModel.getExchangeResultAmountString(
                from: viewModel.currentSecondCurrecny,
                to: viewModel.currentFirstCurrency,
                currencyAmount: number)
        }
        return resultString
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "showCurrencyList",
           let viewController = segue.destination as? CurrencyChooseViewController {
            viewController.currencySide = viewModel.currentCurrencyForChange
        }
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        updateTimeButton.setTitle(String(viewModel.timePeriodForUpdate), for: .normal)
    }

}

