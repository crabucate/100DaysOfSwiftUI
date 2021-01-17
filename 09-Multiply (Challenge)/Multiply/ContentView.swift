//
//  ContentView.swift
//  Multiply
//
//  Created by Felix Leitenberger on 13.01.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPlaying = false
    @State private var tables = Array(1...12)
    
    @State private var numberOfQuestions = ["10", "20", "All"]
    @State private var numberOfQuestionsIndex = 0
    
    var body: some View {
            if isPlaying {
                Game(isPlaying: $isPlaying, tables: $tables, numberOfQuestions: $numberOfQuestions, numberOfQuestionsIndex: $numberOfQuestionsIndex)
            } else {
                Settings(isPlaying: $isPlaying, tables: $tables, numberOfQuestions: $numberOfQuestions, numberOfQuestionsIndex: $numberOfQuestionsIndex)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
