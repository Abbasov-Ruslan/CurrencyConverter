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
    func saveRate(currencyRateFirstToSecond: Double, currencyRateSecondToFirst: Double, currencyRatio: RateCases) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            //
//            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CurrencyRate")
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            do {
//                try managedContext.persistentStoreCoordinator?.execute(deleteRequest, with: managedContext)
//            } catch let error as NSError {
//                // TODO: handle the error
//            }

            //

            let entity =  NSEntityDescription.entity(forEntityName: "CurrencyRate",
                                                     in: managedContext)

            let rate = NSManagedObject(entity: entity!,
                                       insertInto: managedContext)

            rate.setValue(currencyRateFirstToSecond, forKey: currencyRatio.rawValue)

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func getRate(currencyRatio: RateCases) -> Double? {
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
        let rate = currentRate[0]
        return rate.value(forKeyPath: "rubUsd") as? Double
    }

}
