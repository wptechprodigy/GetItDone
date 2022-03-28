//
//  TaskItemsTableViewCell.swift
//  GetItDone
//
//  Created by waheedCodes on 18/03/2022.
//

import UIKit

final class TaskItemsTableViewCell: UITableViewCell {
    
    // MARK: -
    var model: TaskItem? {
        didSet {
            if let taskItem = model {
                taskItemTitleLabel.text = taskItem.title
            }
        }
    }
    
    private lazy var taskItemTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("It has not been implemented")
    }
    
    // MARK: - Object behaviours
    
    private func setupView() {
        contentView.addSubview(taskItemTitleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskItemTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskItemTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskItemTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskItemTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
