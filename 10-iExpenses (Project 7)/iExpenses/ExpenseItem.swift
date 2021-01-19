//
//  ExpenseItem.swift
//  iExpenses
//
//  Created by Felix Leitenberger on 17.01.21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id: UUID
        let name: String
        let type: String
        let amount: Int

        init(id: UUID = UUID(), name: String, type: String, amount: Int) {
            self.id = id
            self.name = name
            self.type = type
            self.amount = amount
        }
    }
