//  AuthModalViewController.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.

import UIKit

enum AuthType {
    case login
    case signup
}

class AuthModalViewController: UIViewController {
    
    private let authType: AuthType

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(hex: "#14b7a6")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hex: "#14b7a6")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(authType: AuthType) {
        self.authType = authType
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet // Используем стандартный стиль
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#0d2122")
        setupUI()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(actionButton)

        titleLabel.text = authType == .login ? "Sign In" : "Sign Up"
        actionButton.setTitle(authType == .login ? "Log In" : "Register", for: .normal)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        setupFields()
    }

    private func setupFields() {
        let fields = createFields()
        fields.forEach { stackView.addArrangedSubview($0) }
    }

    private func createFields() -> [UITextField] {
        let commonFieldStyle: (UITextField) -> Void = { textField in
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(hex: "#0b0d0e")
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(hex: "#14b7a6").cgColor
            textField.textColor = .white
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let usernameOrEmailField = UITextField()
        usernameOrEmailField.placeholder = authType == .login ? "Username or Email" : "Username"
        commonFieldStyle(usernameOrEmailField)
        
        let emailField = UITextField()
        emailField.placeholder = "Email"
        commonFieldStyle(emailField)
        
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        commonFieldStyle(passwordField)
        
        let confirmPasswordField = UITextField()
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.isSecureTextEntry = true
        commonFieldStyle(confirmPasswordField)

        if authType == .login {
            return [usernameOrEmailField, passwordField]
        } else {
            return [usernameOrEmailField, emailField, passwordField, confirmPasswordField]
        }
    }
}
