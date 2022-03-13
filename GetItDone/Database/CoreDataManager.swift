//
//  CoreDataManager.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    
    // MARK: - Properties
    
    var managedObjectContext = NSManagedObjectContext(
        concurrencyType: .mainQueueConcurrencyType)
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetItDone")
        container.loadPersistentStores { _ , error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(String(describing: error)), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    // MARK: - Initialization
    
    private init() {
        managedObjectContext = self.persistentContainer.viewContext
    }
    
    // MARK: - Methods
    
    internal func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error {
                let error = error as NSError
                fatalError("Unresolved error \(String(describing: error)), \(error.userInfo)")
            }
        }
    }
}
