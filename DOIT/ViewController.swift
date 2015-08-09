//
//  ViewController.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var dataContainer = Array(count:4, repeatedValue:[TodoDataClass]())
    
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
        self.performSegueWithIdentifier("showTodoDetail", sender: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataContainer.count;
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section
        {
            case 0:
                return typeOfTodo.urgent.rawValue
            case 1:
                return typeOfTodo.normal.rawValue
            case 2:
                return typeOfTodo.casual.rawValue
            case 3:
                return typeOfTodo.done.rawValue
            default:
                return typeOfTodo.normal.rawValue
        }

    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataContainer[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuse") as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "reuse")
        }
        
        var data = dataContainer[indexPath.section][indexPath.row] as TodoDataClass
        
        cell!.textLabel?.text = data.title
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showTodoDetail", sender: dataContainer[indexPath.section][indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showTodoDetail")
        {
            var vc : TodoDetailViewController = segue.destinationViewController
            
            if (sender != nil)//means show the data
            {
                
            }
            else{//means new data
                
            }
        }
    }

}

