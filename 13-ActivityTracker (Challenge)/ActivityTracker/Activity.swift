//
//  Activity.swift
//  ActivityTracker
//
//  Created by Felix Leitenberger on 25.01.21.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    var amount: Int = 0
}
