//
//  Prospect.swift
//  HotProspects
//
//  Created by Felix Leitenberger on 04.04.21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var addedAt = Date()
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]

    init() {
        do {
            let url = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("prospects.json")
            if let data = FileManager.default.contents(atPath: url.path) {
                if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                    self.people = decoded
                    return
                }
            }
        } catch {
            print("No init possible")
    }

    self.people = []
}

private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
        if let url = getApplicationSupportDirectory()?.appendingPathComponent("prospects.json") {
            do {
                try encoded.write(to: url)
            } catch {
                print("Not able to save")
            }
        }
    }
}

func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
}

func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
}

    enum Sorter {
        case name, addedAt
    }

    func sort(by sorter: Sorter) {
        if sorter == .name {
            people.sort { (lhs, rhs) -> Bool in
                lhs.name < rhs.name
            }
        } else if sorter == .addedAt {
            people.sort { (lhs, rhs) -> Bool in
                lhs.addedAt > rhs.addedAt
            }
        }
    }

func getApplicationSupportDirectory() -> URL? {
    let fileURL: URL

    do {
        fileURL = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
    }
    catch {
        return nil
    }
    return fileURL
}
}
