//
//  User.swift
//  FriendFace
//
//  Created by Felix Leitenberger on 10.02.21.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let friends: [Friend]
    
    struct Friend: Codable, Identifiable, Hashable {
        let id: String
        let name: String
    }
}
