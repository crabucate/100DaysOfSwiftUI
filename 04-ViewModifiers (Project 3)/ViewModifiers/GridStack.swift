//
//  GridStack.swift
//  ViewModifiers
//
//  Created by Felix Leitenberger on 02.01.21.
//

import SwiftUI

struct GridStack<Content: View>:View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    // this is needed for viewbuilder
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
