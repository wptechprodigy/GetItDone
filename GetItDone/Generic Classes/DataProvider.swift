//
//  DataProvider.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import Foundation
import CoreData

protocol DataProviderDelegate: AnyObject {
    func didInsertItem(at indexPath: IndexPath)
    func didDeleteItem(at indexPath: IndexPath)
}

final class DataProvier<T: NSManagedObject>:
    NSObject, NSFetchedResultsControllerDelegate {
    
    // MARK: - Delegating Object
    weak var delegate: DataProviderDelegate?
    
    // MARK: - Properties
    
    private var managedObjectContext: NSManagedObjectContext
    private var sortDescriptors: [NSSortDescriptor]
    private var predicate: NSPredicate?
    
    private lazy var request: NSFetchRequest<T> = {
        let request = NSFetchRequest<T>(
            entityName: String(describing: T.self))
        request.sortDescriptors = self.sortDescriptors
        if let predicate = predicate {
            request.predicate = predicate
        }
        return request
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController<T> = {
        let fetchedResult = NSFetchedResultsController<T>(
            fetchRequest: request,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResult.delegate = self
        return fetchedResult
    }()
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext,
         sortDescriptors: [NSSortDescriptor],
            predicate: NSPredicate? = nil) {
        self.managedObjectContext = managedObjectContext
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
        
        super.init()
        performFetch()
    }
    
    func performFetch() {
        do {
            try fetchedResultController.performFetch()
        } catch let fetchError {
            print(fetchError.localizedDescription)
        }
    }
    
    func objectAtIndex(indexPath: IndexPath) -> T {
        return fetchedResultController.object(at: indexPath)
    }
    
    func numberOfSections() -> Int {
        return fetchedResultController.sections?.count ?? 1
    }
    
    func rowsInSection(section: Int) -> Int {
        return fetchedResultController
            .sections?[section]
            .numberOfObjects ?? 0
    }
    
    func deleteItem(at indexPath: IndexPath) {
        let item = objectAtIndex(indexPath: indexPath)
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch let saveError {
            print(saveError.localizedDescription)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                if let indexPath = newIndexPath {
                    delegate?.didInsertItem(at: indexPath)
                }
            case .delete:
                if let indexPath = indexPath {
                    delegate?.didDeleteItem(at: indexPath)
                }
            case .move, .update:
                break
            @unknown default:
                fatalError("Unknown fetched result type")
        }
    }
}
