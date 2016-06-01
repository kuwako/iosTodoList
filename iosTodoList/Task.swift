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
    dynamic var taskName: String? = ""
    dynamic var deadline: String? = ""
    
    convenience init(taskName: String, deadline: String) {
        self.init()
        self.taskName = taskName
        self.deadline = deadline
    }
    
    
}
//
//let aDefaultRealm = Realm()
//
//var anObject = Task(taskName: "飲み会の予約", deadline: "John")
//aDefaultRealm.write {
//    aDefaultRealm.add(anObject)
//}