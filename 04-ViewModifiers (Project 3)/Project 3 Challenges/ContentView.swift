//
//  ContentView.swift
//  Project 3 Challenges
//
//  Created by Felix Leitenberger on 03.01.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .prominentTitle()
    }
}


// Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 80, weight: .black, design: .rounded))
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
