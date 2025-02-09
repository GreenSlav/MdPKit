//  AuthViewController.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.

import UIKit

class AuthViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(hex: "#14b7a6")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(hex: "#0d2122")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor(hex: "#14b7a6")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#0b0d0e")
        setupLayout()
        activityIndicator.startAnimating()
        checkAuthentication()
        
        loginButton.addTarget(self, action: #selector(showLoginModal), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(showSignUpModal), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            loginButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func checkAuthentication() {
        if let token = TokenManager.shared.getToken() {
            if NetworkMonitor.shared.isConnected {
                AuthService.shared.verifyToken(token: token) { [weak self] isValid in
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        if isValid {
                            self?.navigateToMainScreen()
                        } else {
                            TokenManager.shared.deleteToken()
                            self?.showAuthButtons()
                        }
                    }
                }
            } else {
                activityIndicator.stopAnimating()
                navigateToMainScreen()
            }
        } else {
            activityIndicator.stopAnimating()
            showAuthButtons()
        }
    }
    
    private func showAuthButtons() {
        loginButton.isHidden = false
        signUpButton.isHidden = false
    }
    
    private func navigateToMainScreen() {
        let documentsVC = DocumentsViewController()
        let navController = UINavigationController(rootViewController: documentsVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    
    @objc private func showLoginModal() {
        let loginVC = AuthModalViewController(authType: .login)
        present(loginVC, animated: true, completion: nil)
    }

    @objc private func showSignUpModal() {
        let signUpVC = AuthModalViewController(authType: .signup)
        present(signUpVC, animated: true, completion: nil)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// В AppDelegate или SceneDelegate установи этот экран как стартовый:
// window.rootViewController = AuthViewController()
