//
//  CoreDataHelper.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 02.09.2022.
//

import CoreData
import UIKit

enum RateCases: String {
    case usdRub
    case rubUsd
}

class CoreDataManager {
    func saveRate(currencyRateFirstToSecond: Double, currencyRateSecondToFirst: Double, currencyRatioFirst: RateCases, currencyRatioSecond: RateCases) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            let entity =  NSEntityDescription.entity(forEntityName: "CurrencyRate",
                                                     in: managedContext)

            let rate = NSManagedObject(entity: entity!,
                                       insertInto: managedContext)

            rate.setValue(currencyRateFirstToSecond, forKey: currencyRatioFirst.rawValue)
            rate.setValue(currencyRateSecondToFirst, forKey: currencyRatioSecond.rawValue)

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func getRate(currencyRatio: RateCases) -> Double? {
        guard let currentRate = retrieveData() else {
            return nil
        }

        let rate = currentRate[0]
        return rate.value(forKeyPath: currencyRatio.rawValue) as? Double
    }

    func retrieveData() -> [NSManagedObject]? {
        var currentRate: [NSManagedObject] = []

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CurrencyRate")

        do {
            currentRate = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return currentRate
    }

    func isDatabaseHaveCash() -> Bool {
        let currentRate = retrieveData()
        if currentRate?.count != 0 {
            return true
        } else {
            return false
        }
    }

    func clearCurrencyDataBase() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CurrencyRate")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.persistentStoreCoordinator?.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print(" \(error), \(error.userInfo)")
        }
    }

}
