//
//  TodoDataClass.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import Foundation

enum typeOfTodo : String
{
    case urgent = "Urgent"
    case normal = "Normal"
    case casual = "Casual"
    case done = "Done"
    
}


class TodoDataClass: NSObject {
    
    var title : String
    var type : typeOfTodo
    var done = false
    
    
    init(title : String , type: typeOfTodo)
    {
        self.title = title
        self.type = type
        
    }
    
}