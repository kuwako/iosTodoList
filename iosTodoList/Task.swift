//
//  Task.swift
//  iosTodoList
//
//  Created by 桑古　昌輝 on 2016/03/30.
//  Copyright © 2016年 桑古　昌輝. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object {
    dynamic var taskName:NSString
    dynamic var deadline:NSString
    
    init(taskName: String, deadline: String){
        self.taskName = taskName
        self.deadline = deadline
    }
  
}