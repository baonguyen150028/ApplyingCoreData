//
//  ViewController.swift
//  toDoListApp
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    let dataController = DataController.shareInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)

    }
    @IBAction func save() {

        guard let text = textField.text else { return }

        let item = NSEntityDescription.insertNewObject(forEntityName: Item.identifier, into: dataController.managedObjectContext) as! Item
        
        item.text = text
        dataController.saveContext()
        dismiss(animated: true, completion: nil)
    }

}

















