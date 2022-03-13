//
//  CoreDataManager+Extensions.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import Foundation
import CoreData

extension CoreDataManager {
    func saveTask(name: String) {
        let task = Task(context: managedObjectContext)
        task.title = name
        saveContext()
    }
    
    func saveTaskItem(task: String, uniqueTaskItem: String) {
        let taskItem = TaskItem(context: managedObjectContext)
        taskItem.task = task
        taskItem.title = uniqueTaskItem
        saveContext()
    }
}
