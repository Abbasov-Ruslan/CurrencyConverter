//
//  TimerChooseViewController.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 05.09.2022.
//

import UIKit

class TimerChooseViewController: UITableViewController {

    var timerArray = [15, 30, 60]
    var resultPeriod = 15

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath)
        cell.textLabel?.text = String(timerArray[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultPeriod = timerArray[indexPath.row]
        performSegue(withIdentifier: "unwindToRoot", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "unwindToRoot",
           let viewController = segue.destination as? CurrencyMainViewController {
            viewController.viewModel.timePeriodForUpdate = TimeInterval(resultPeriod)
            viewController.viewModel.restartTimer(timeInterval: TimeInterval(resultPeriod * 60))
        }
    }
}
