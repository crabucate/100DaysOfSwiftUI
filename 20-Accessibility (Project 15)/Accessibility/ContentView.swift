//
//  ContentView.swift
//  Accessibility
//
//  Created by Felix Leitenberger on 06.03.21.
//

import SwiftUI

struct ContentView: View {

    @State private var estimate = 25.0
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        VStack {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    self.selectedPicture = Int.random(in: 0...3)
                }
                .accessibility(label: Text(labels[selectedPicture]))
                .accessibility(addTraits: .isButton)
                .accessibility(removeTraits: .isImage)
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)

            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("Your score is 1000"))
            Slider(value: $estimate, in: 0...50)
                .accessibility(value: Text("\(Int(estimate))"))
                    .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
