//
//  TaskListTableViewCell.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import UIKit

final class TaskListTableViewCell: UITableViewCell {
    
    var model: Task? {
        didSet {
            if let task = model {
                taskTitleLabel.text = task.title
            }
        }
    }
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Object methods
    
    private func setupView() {
        contentView.addSubview(taskTitleLabel)
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            taskTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
