//
//  ViewController.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import UIKit
import Parse
import AIFlatSwitch

class ViewController: UITableViewController {

    var dataContainer = Array(count:4, repeatedValue:[TodoDataClass]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = Selector("addBtnPressed")
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("modifyObject:"), name: "modifyObject", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("addObject:"), name: "addObject", object: nil)
        
        self.refreshControl!.addTarget(self, action: "refreshWithParse", forControlEvents: UIControlEvents.ValueChanged)
        refreshWithParse()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func refreshWithParse()
    {
        var query = PFQuery(className:"ToDos")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                // There was an error
            } else {
                self.updateDataContainer(objects)
                self.refreshControl!.endRefreshing()
                self.tableView.reloadData()
                // objects has all the Posts the current user liked.
            }
        }
    }
    
    func updateDataContainer(objects: [AnyObject]?)
    {
        dataContainer = Array(count:4, repeatedValue:[TodoDataClass]())
        if(objects != nil)
        {
            for object in objects!
            {
                
                let type = object["type"] as! String
                let objectOfType = object as! PFObject
                
                var typeOfObject = typeOfTodo(rawValue: type)!.hashValue
                dataContainer[typeOfObject].append(TodoDataClass(parse: objectOfType, ready: true))
            }
        }
        
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
        
        var cell: CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuse") as? CustomTableViewCell
        
        if cell == nil
        {
            cell = CustomTableViewCell()
        }
        
        var data = dataContainer[indexPath.section][indexPath.row] as TodoDataClass
        
        cell!.textLabel?.text = data.title
        
        
        if(data.type == typeOfTodo.done)
        {
            cell!.doneUI.setSelected(true, animated: false)
            cell!.doneUI.enabled = false;
        }
        else
        {
            cell!.doneUI.setSelected(false, animated: false)
            cell!.doneUI.enabled = true;
        }
        cell!.onDoneTapped = {
            
            self.dataContainer[data.type.hashValue].remove(data)
            data.type = typeOfTodo.done
            self.dataContainer[data.type.hashValue].append(data)
            
            self.updateDataWithDataClass(data)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            
            
        }
        
        cell!.doneUI.addTarget(cell, action: "doneBtnPressed", forControlEvents: UIControlEvents.ValueChanged)
        
        
        if data.ready == false
        {
            cell!.userInteractionEnabled = false
        }
        else
        {
            cell!.userInteractionEnabled = true
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showTodoDetail", sender: dataContainer[indexPath.section][indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showTodoDetail")
        {
            var vc = segue.destinationViewController as! TodoDetailViewController
            
            
            if let data = sender as? TodoDataClass
            {
                vc.dataToshow = data
            }
        }
    }
    
    func modifyObject(notification: NSNotification){
        
        if let data = notification.object as? TodoDataClass
        {
            if let info = notification.userInfo as? Dictionary<String,Int> {
                
                if( data.type != typeOfTodo.rawToType(info["newType"]!) )
                {
                    dataContainer[data.type.hashValue].remove(data)
                    data.type = typeOfTodo.rawToType(info["newType"]!)
                    dataContainer[data.type.hashValue].append(data)
                    updateDataWithDataClass(data)
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    func updateDataWithDataClass(data: TodoDataClass)
    {
        var query = PFQuery(className:"ToDos")
        query.getObjectInBackgroundWithId(data.parseObject!.objectId!) {
            (todoObject: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let todoObject = todoObject {
                todoObject["title"] = data.title
                todoObject["type"] = data.type.rawValue
                todoObject.saveInBackground()
            }
        }
    }
    
    func addObject(notification: NSNotification){
        
        
        
        var data = notification.object as? TodoDataClass
        
        let todoObject = PFObject(className: "ToDos")
        todoObject["title"] = data!.title
        todoObject["type"] = data!.type.rawValue
        
        data = TodoDataClass(parse: todoObject, ready: false)
        dataContainer[data!.type.hashValue].append(data!)
        
        todoObject.saveInBackgroundWithBlock { (bool, error) -> Void in
            data?.ready = true
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        
    }

}

