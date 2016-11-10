//
//  Item+CoreDataProperties.swift
//  toDoListApp
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        let request =  NSFetchRequest<Item>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request;
    }

    @NSManaged public var text: String?
    @NSManaged public var completed: Bool

}
