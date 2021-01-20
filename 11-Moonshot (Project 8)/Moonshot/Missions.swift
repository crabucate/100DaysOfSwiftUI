//
//  Missions.swift
//  Moonshot
//
//  Created by Felix Leitenberger on 19.01.21.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var launchYear: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter.string(from: launchDate)
        } else {
            return "Never"
        }
    }
    
    var crewNames: String {
        var names = String()
        for person in crew {
            names.append("\(person.name)\n")
        }
        return names
    }
}
