//
//  CurrencyChooseViewController.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 05.09.2022.
//

import UIKit

class CurrencyChooseViewController: UITableViewController  {

    var currecyChoose: Currency = .EUR
    var currencySide: ExchnageDirection = .leftToRight

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currency.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        cell.textLabel?.text = Currency.allCases[indexPath.row].rawValue

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currecyChoose = Currency.allCases[indexPath.row]
        navigationController?.popViewController(animated: true)
        if let vc = presentingViewController as? CurrencyMainViewController {
            dismiss(animated: true, completion: { [weak self] in
                if vc.viewModel.currentCurrencyForChange == .leftToRight {
                    vc.viewModel.currentFirstCurrency = self?.currecyChoose ?? .RUB
                } else {
                    vc.viewModel.currentSecondCurrecny = self?.currecyChoose ?? .RUB
                }
            })
        }
    }
}
