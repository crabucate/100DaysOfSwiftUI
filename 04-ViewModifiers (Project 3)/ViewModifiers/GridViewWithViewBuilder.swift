//
//  GridViewWithViewBuilder.swift
//  ViewModifiers
//
//  Created by Felix Leitenberger on 02.01.21.
//

import SwiftUI

struct GridViewWithViewBuilder: View {
    var body: some View {
        VStack {
            GridStack(rows: 4, columns: 4) { row, col in
                VStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.gray)
                .padding()
            }
            Spacer()
            Text("This grid uses the custom initializer with a @ViewBuilder closure: \n@ViewBuilder content: @escaping (Int, Int) -> Content ")
        }
    }
}
