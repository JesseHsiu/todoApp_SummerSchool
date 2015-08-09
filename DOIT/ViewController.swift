//
//  ViewController.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = Selector("addBtnPressed")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addBtnPressed(){
        let todoVC : TodoDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("detail") as! TodoDetailViewController
        self.navigationController!.pushViewController(todoVC, animated: true)
    }

}

