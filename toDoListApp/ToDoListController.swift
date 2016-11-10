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


    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailController" {
            guard let controller = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            controller.item = dataSource.object(at: indexPath)
        }
    }

    
    // UITableView Delegate 
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {

        return .delete
    }

}







