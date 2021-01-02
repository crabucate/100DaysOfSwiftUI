//
//  GridStack.swift
//  ViewModifiers
//
//  Created by Felix Leitenberger on 02.01.21.
//

import SwiftUI

struct GridStack<Content: View>:View {
    var body: some View {
    
    let rows: Int
        let columns: Int
        let content: (Int, Int) -> Content
    
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

