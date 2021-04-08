//
//  Card.swift
//  Flashzilla
//
//  Created by Felix Leitenberger on 07.04.21.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String

    static var example: Card {
        Card(prompt: "Prompt 1", answer: "Answer 1")
    }
}
