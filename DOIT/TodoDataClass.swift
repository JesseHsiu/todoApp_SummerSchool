//
//  TodoDataClass.swift
//  DOIT
//
//  Created by 修敏傑 on 8/9/15.
//  Copyright (c) 2015 NTU. All rights reserved.
//

import Foundation
import Parse

enum typeOfTodo : String
{
    case urgent = "Urgent"
    case normal = "Normal"
    case casual = "Casual"
    case done = "Done"
    
    static func rawToType(value: Int) -> typeOfTodo {
        
        switch value {
        case 0: return .urgent
        case 1: return .normal
        case 2: return .casual
        case 3: return .done
        default: return .done
        }
    }
    
}


class TodoDataClass: NSObject {
    
    var title : String
    var type : typeOfTodo
    var done = false
    var parseObject : PFObject?
    
    
    init(title : String , type: typeOfTodo)
    {
        self.title = title
        self.type = type
        
    }
    
    init(parse: PFObject)
    {
        self.parseObject = parse
        self.title = parse["title"] as! String
        self.type = typeOfTodo(rawValue: parse["type"] as! String)!
    }
    
}