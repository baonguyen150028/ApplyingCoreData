//
//  TableViewController.swift
//  toDoListApp
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import CoreData
class ToDoListController: UITableViewController, NSFetchedResultsControllerDelegate {


    let managedObjectContext = DataController.shareInstance.managedObjectContext

   
    lazy var fetchedResultsController: ToDoFetchResultController = {
        let controller = ToDoFetchResultController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailController" {
            guard let controller = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            controller.item = fetchedResultsController.object(at: indexPath)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        return configureCell(cell: cell, atIndexPath: indexPath)
    }
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath ) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath) 
        cell.textLabel?.text = item.text
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        let item = fetchedResultsController.object(at: indexPath) as NSManagedObject
        managedObjectContext.delete(item)
        DataController.shareInstance.saveContext()
    }

    // UITableView Delegate 
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {

        return .delete
    }

}







