//
//  CoreDataController.swift
//  MoneyTracker
//
//  Created by Dean Gaffney on 28/11/2016.
//  Copyright © 2016 Dean Gaffney. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController{
    
    private init(){
        
    }
    
    class func getContext() -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MoneyTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
   class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func createNewItem(name:String,cost: Double,purchaseDate: Date,category:String,owningTracker: Tracker)->Item{
        let item: Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: CoreDataController.getContext()) as! Item
        item.name = name
        item.cost = cost
        item.category = category
        item.purchaseDate = purchaseDate as NSDate?
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let dateString = formatter.string(from: purchaseDate)
        let dateComponenets = dateString.components(separatedBy: "/")
        item.purchaseDay = Int32(dateComponenets[1])!
        item.purchaseMonth = Int32(dateComponenets[0])!
        item.purchaseYear = Int32(dateComponenets[2])!
        item.tracker = owningTracker
        return item
    }
    
    //retuns all products in database
    class func retrieveProducts() ->[Item]{
        var results = [Item]()
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            results = try CoreDataController.getContext().fetch(fetchRequest) 
        } catch  {
            print("Error: \(error)")
        }
        return results
    }
    
    //return all trackers from database
    class func retrieveTrackers()->[Tracker]{
        var results = [Tracker]()
        let fetchRequest: NSFetchRequest<Tracker> = Tracker.fetchRequest()
        do {
            results = try CoreDataController.getContext().fetch(fetchRequest) 
        } catch  {
            print("Error: \(error)")
        }
        return results
    }
    
    //create new tracker to be stored
    class func createNewTracker(name: String, creationDate: Date) ->Tracker{
        let tracker: Tracker = NSEntityDescription.insertNewObject(forEntityName: "Tracker", into: CoreDataController.getContext()) as! Tracker
        tracker.name = name
        tracker.date = creationDate as NSDate?
        
        return tracker
    }
    
    //get cost of all items in tracker
    class func totalCost(tracker: Tracker)->Double{
        var result: Double = 0
        for item in tracker.items!{
            result += (item as! Item).cost
        }
        return result
    }
}
