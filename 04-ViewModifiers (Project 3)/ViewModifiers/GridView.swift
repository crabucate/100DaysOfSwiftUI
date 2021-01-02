//
//  GridView.swift
//  ViewModifiers
//
//  Created by Felix Leitenberger on 02.01.21.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        VStack {
            GridStack(rows: 3, columns: 3) { row, col in
                Text("R\(row) C\(col)")
                    .frame(width: 80, height: 80)
                    .background(Color.init(.sRGB, red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), opacity: .random(in: 0...1)))
                    .padding()
            }
            Spacer()
            Text("This GridStack ist made with a custom container.\n struct GridStack<Content: View>:View {}")
            Spacer()
            NavigationLink(
                destination: GridViewWithViewBuilder(),
                label: {
                    Text("Let's create a grid with a @ViewBuilder.")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                })
        }
        }
}
