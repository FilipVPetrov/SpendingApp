//
//  Item+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by Dean Gaffney on 28/11/2016.
//  Copyright © 2016 Dean Gaffney. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var cost: Double
    @NSManaged public var name: String?
    @NSManaged public var purchaseDate: NSDate?
    @NSManaged public var purchaseDay: Int32
    @NSManaged public var purchaseMonth: Int32
    @NSManaged public var purchaseYear: Int32
    @NSManaged public var category: String?
    @NSManaged public var tracker: Tracker?

}
