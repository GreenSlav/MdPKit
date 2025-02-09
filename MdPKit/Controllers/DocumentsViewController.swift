//
//  DocumentsViewController.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.
//

//  DocumentsViewController.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.

import UIKit

class DocumentsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Documents"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(hex: "#14b7a6")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#0b0d0e")
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
