//
//  AddNewItemViewController.swift
//  GetItDone
//
//  Created by waheedCodes on 14/03/2022.
//

import UIKit

protocol AddNewItemViewControllerDelegate: AnyObject {
    func saveNewItem(item: String)
}

final class AddNewItemViewController: UIViewController {
    
    weak var delegate: AddNewItemViewControllerDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Add New"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Add new item..."
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Object Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Object Methods
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        guard let text = titleTextField.text,
              !text.isEmpty else { return }
        
        delegate?.saveNewItem(item: text)
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        [titleLabel, titleTextField, saveButton].forEach {
            view.addSubview($0)
        }
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        // Title label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 32)
        ])
        
        // Title text field
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 8)
        ])
        
        // Save button
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -16),
            saveButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,
                                            constant: 16),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
