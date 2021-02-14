//
//  NetworkManager.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 10.02.21.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func getUsers(completed: @escaping (Result<[User], Error>) -> Void) {
        
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") {
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    
                    if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                        completed(.success(decodedUsers))
                    }
                }
            }.resume()
        }
    }
}
