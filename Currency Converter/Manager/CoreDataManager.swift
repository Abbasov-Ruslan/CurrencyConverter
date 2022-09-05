//
//  CoreDataHelper.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 02.09.2022.
//

import CoreData
import UIKit

class CoreDataManager {
    func saveRate(currencyRateFirstToSecond: Double, currencyRateSecondToFirst: Double, currencyNameFirst: Currency, currencyNameSecond: Currency) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            let entity =  NSEntityDescription.entity(forEntityName: "CurrencyRate",
                                                     in: managedContext)

            let rate = NSManagedObject(entity: entity!,
                                       insertInto: managedContext)

            rate.setValue(currencyRateFirstToSecond, forKey: currencyNameFirst.rawValue.lowercased() + currencyNameSecond.rawValue)
            rate.setValue(currencyRateSecondToFirst, forKey: currencyNameSecond.rawValue.lowercased() + currencyNameFirst.rawValue.uppercased())

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func addRateToDB(currencyRateFirstToSecond: Double, currencyRateSecondToFirst: Double, currencyNameFirst: Currency, currencyNameSecond: Currency) {
        DispatchQueue.main.async { [self] in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            let entity =  NSEntityDescription.entity(forEntityName: "CurrencyRate",
                                                     in: managedContext)

            let rate = self.retrieveData()?.first

            rate?.setValue(currencyRateFirstToSecond, forKey: currencyNameFirst.rawValue.lowercased() + currencyNameSecond.rawValue)
            rate?.setValue(currencyRateSecondToFirst, forKey: currencyNameSecond.rawValue.lowercased() + currencyNameFirst.rawValue.uppercased())

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func getRate(firstCurrency: Currency, secondCurrency: Currency) -> Double? {
        guard let currentRate = retrieveData() else {
            return nil
        }

        let rate = currentRate.first
        return rate?.value(forKeyPath: firstCurrency.rawValue.lowercased() + secondCurrency.rawValue) as? Double
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
