//
//  DataSource.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import UIKit
import CoreData

final class DataSource<Cell: UITableViewCell, Model: NSManagedObject>:
    NSObject, UITableViewDataSource {
    
    // MARK: - Dependencies
    
    var cellIdentifier: String
    var dataProvider: DataProvier<Model>
    var tableView: UITableView?
    var configCell: (Cell, Model) -> Void
    
    // MARK: - Initializers
    
    init(cellIdentifier: String,
         dataProvider: DataProvier<Model>,
         configCell: @escaping (Cell, Model) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.dataProvider = dataProvider
        self.configCell = configCell
        
        super.init()
        self.dataProvider.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataProvider.rowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        let model = dataProvider.objectAtIndex(indexPath: indexPath)
        configCell(cell, model)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataProvider.deleteItem(at: indexPath)
        }
    }
}

extension DataSource: DataProviderDelegate {
    func didInsertItem(at indexPath: IndexPath) {
        tableView?.insertRows(at: [indexPath], with: .automatic)
    }
    
    func didDeleteItem(at indexPath: IndexPath) {
        tableView?.deleteRows(at: [indexPath], with: .automatic)
    }
}
