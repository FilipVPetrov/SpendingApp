//
//  Tracker+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Dean Gaffney. All rights reserved.
//

import Foundation
import CoreData


extension Tracker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tracker> {
        return NSFetchRequest<Tracker>(entityName: "Tracker");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?
    

}

// MARK: Generated accessors for items
extension Tracker {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
