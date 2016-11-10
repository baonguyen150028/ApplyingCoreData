//
//  DetailViewController.swift
//  toDoListApp
//
//  Created by The Bao on 11/10/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else { return }
        textField.text = item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func update() {
        guard let item = item else { return }
        item.text = textField.text
        DataController.shareInstance.saveContext()

        self.navigationController?.popViewController(animated: true)
    }

}
