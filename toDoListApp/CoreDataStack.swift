//
//  CoreDataStack.swift
//  CoreDatainSwift
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject {

    static let shareInstance = DataController()

    private override init() {

    }

    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "toDoList", withExtension: "momd")!

        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("toDoList.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let userInfo: [String: Any] = [
                NSLocalizedDescriptionKey : "Failed to initialize the appliation's saved data.",
                NSLocalizedFailureReasonErrorKey :  "There was an error creating or loading the application's saved data.",
                NSUnderlyingErrorKey : error as NSError
            ]
            let wrappedError = NSError(domain: "thebao.coreDataError", code: 9999, userInfo: userInfo)
            print("Unresolved error: \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()

    public lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved Error \(error), \(error.userInfo)")
            }
        }
    }
}
