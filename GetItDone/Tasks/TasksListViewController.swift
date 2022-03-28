//
//  TasksListViewController.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import UIKit

final class TasksListViewController: UIViewController {
    
    var manager: CoreDataManager
    
    private lazy var tableView: GenericTableView<TaskListTableViewCell, Task> = {
        let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let dataProvider = DataProvier<Task>(
            managedObjectContext: manager.managedObjectContext,
            sortDescriptors: sortDescriptors)
        
        let tableView = GenericTableView<TaskListTableViewCell, Task>(dataProvider: dataProvider) { cell, task in
            cell.model = task
        } selectionHandler: { [weak self] task in
            guard let `self` = self,
                  let taskTitle = task.title else { return }
            let viewController = TaskItemsViewController(taskList: taskTitle, manager: self.manager)
            self.show(viewController, sender: self)
        }
        
        return tableView
    }()
    
    private lazy var addNewTaskButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        button.addTarget(self, action: #selector(didTapAddNewTaskButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initializer
    
    init(manager: CoreDataManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Object Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.performFetch()
    }
    
    // MARK: - Object methods
    
    private func setupView() {
        title = "My Tasks"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        view.addSubview(addNewTaskButton)
        setupContraints()
    }
    
    private func setupContraints() {
        
        // MARK: - Table view
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // MARK: - Add new task button
        
        NSLayoutConstraint.activate([
            addNewTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addNewTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addNewTaskButton.widthAnchor.constraint(equalToConstant: 44),
            addNewTaskButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func didTapAddNewTaskButton(_ sender: UIButton) {
        let viewController = AddNewItemViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension TasksListViewController: AddNewItemViewControllerDelegate {
    func saveNewItem(item: String) {
        manager.saveTask(name: item)
        tableView.performFetch()
    }
}
