//
//  TodoDetailViewController.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import Foundation
import UIKit

class TodoDetailViewController: UIViewController{
    
    var dataToshow : TodoDataClass?
    
    
    @IBOutlet var todoTitle: UITextField!
    @IBOutlet var todoTypeSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(dataToshow != nil)
        {
            todoTitle.text = dataToshow!.title
            switch dataToshow!.type{
                
            case .urgent:
                todoTypeSeg.selectedSegmentIndex = 0
                
            case .normal:
                todoTypeSeg.selectedSegmentIndex = 1
                
            case .casual:
                todoTypeSeg.selectedSegmentIndex = 2
                
            case .done:
                todoTypeSeg.selectedSegmentIndex = 3
            }
        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var currentType = typeOfTodo.rawToType(todoTypeSeg.selectedSegmentIndex)
        
        if let data = dataToshow as TodoDataClass!
        {
            var newSelect = ["newType" : currentType.hashValue]
            data.title = todoTitle.text
            NSNotificationCenter.defaultCenter().postNotificationName("modifyObject", object: data, userInfo: newSelect)
        }
        else
        {
            if(todoTitle.text == ""){
                return
            }
            var newTodo = TodoDataClass(title: todoTitle.text, type: currentType)
            NSNotificationCenter.defaultCenter().postNotificationName("addObject", object: newTodo)
        }
        
        

    }

    
}