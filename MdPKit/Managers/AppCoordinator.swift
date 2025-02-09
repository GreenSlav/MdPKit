//
//  AppCoordinator.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.
//

import UIKit

class AppCoordinator {
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        if let token = TokenManager.shared.getToken() {
            if NetworkMonitor.shared.isConnected {
                validateToken(token)
            } else {
                showMainScreen()
            }
        } else {
            showLoginScreen()
        }
    }

    private func validateToken(_ token: String) {
        AuthService.shared.verifyToken(token: token) { [weak self] isValid in
            DispatchQueue.main.async {
                if isValid {
                    self?.showMainScreen()
                } else {
                    TokenManager.shared.deleteToken()
                    self?.showLoginScreen()
                }
            }
        }
    }

    private func showLoginScreen() {
        let loginVC = AuthViewController()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }

    private func showMainScreen() {
        let documentsVC = DocumentsViewController() // Контроллер для главного экрана с документами
        let navController = UINavigationController(rootViewController: documentsVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
