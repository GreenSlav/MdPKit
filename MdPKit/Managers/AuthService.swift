//
//  AuthService.swift
//  MdPKit
//
//  Created by green_sl on 9.2.2025.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    private let baseURL = URL(string: "https://your-api-url.com/api/auth/verify")!

    func verifyToken(token: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            completion(httpResponse.statusCode == 200)
        }
        task.resume()
    }
}
