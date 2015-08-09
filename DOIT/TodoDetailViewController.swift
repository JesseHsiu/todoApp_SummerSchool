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
                todoTypeSeg.selectedSegmentIndex = 4
            }
        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var currentType : typeOfTodo!
        switch todoTypeSeg.selectedSegmentIndex
        {
        case 0:
            currentType = typeOfTodo.urgent
        case 1:
            currentType = typeOfTodo.normal
        case 2:
            currentType = typeOfTodo.casual
        default:
            break
        }
        
        
        
        if let data = dataToshow as TodoDataClass!
        {
            data.title = todoTitle.text
            data.type = currentType
            NSNotificationCenter.defaultCenter().postNotificationName("modifyObject", object: data)
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