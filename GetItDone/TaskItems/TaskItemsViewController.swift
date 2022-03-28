//
//  TaskItemsViewController.swift
//  GetItDone
//
//  Created by waheedCodes on 18/03/2022.
//

import UIKit

final class TaskItemsViewController: UIViewController {
    
    // MARK: -  Properties
    
    var taskList: String
    var manager: CoreDataManager
    
    private lazy var taskItemsTableView: GenericTableView<TaskItemsTableViewCell, TaskItem> = {
        let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let predicate = NSPredicate(format: "task == %@", taskList)
        
        let dataProvider = DataProvier<TaskItem>(
            managedObjectContext: manager.managedObjectContext,
            sortDescriptors: sortDescriptors,
            predicate: predicate)
        
        let tableView = GenericTableView<TaskItemsTableViewCell, TaskItem>(dataProvider: dataProvider) { cell, taskItem in
            cell.model = taskItem
        } selectionHandler: { taskItem in
            print("\(taskItem.title ?? "") selected")
        }

        return tableView
    }()
    
    private lazy var addNewTaskItemButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        button.addTarget(self, action: #selector(didTapAddNewTaskItemButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initialzers
    
    init(taskList: String, manager: CoreDataManager) {
        self.taskList = taskList
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("It has not been implemented")
    }
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        taskItemsTableView.performFetch()
    }
    
    // MARK: - Object behaviours
    
    private func setupView() {
        title = taskList
        view.backgroundColor = .systemBackground
        view.addSubview(taskItemsTableView)
        view.addSubview(addNewTaskItemButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskItemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskItemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskItemsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            taskItemsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addNewTaskItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addNewTaskItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addNewTaskItemButton.widthAnchor.constraint(equalToConstant: 44),
            addNewTaskItemButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func didTapAddNewTaskItemButton(_ sender: UIButton) {
        let viewController = AddNewItemViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension TaskItemsViewController: AddNewItemViewControllerDelegate {
    func saveNewItem(item: String) {
        manager.saveTaskItem(task: taskList, uniqueTaskItem: item)
        taskItemsTableView.performFetch()
    }
}
