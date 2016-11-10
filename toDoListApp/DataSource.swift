//
//  DataSource.swift
//  toDoListApp
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DataSource: NSObject, UITableViewDataSource {
    private let tableView: UITableView

    let managedObjectContext = DataController.shareInstance.managedObjectContext

    lazy var fetchedResultsController: ToDoFetchResultController = {
        let controller = ToDoFetchResultController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        return controller
    }()

    init(tableView: UITableView) {
        self.tableView = tableView
    }
    func object(at indexPath: IndexPath) -> Item {
        return fetchedResultsController.object(at: indexPath)
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        return configureCell(cell: cell, atIndexPath: indexPath)
    }
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath ) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = item.text
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        let item = fetchedResultsController.object(at: indexPath) as NSManagedObject
        managedObjectContext.delete(item)
        DataController.shareInstance.saveContext()
    }

}
