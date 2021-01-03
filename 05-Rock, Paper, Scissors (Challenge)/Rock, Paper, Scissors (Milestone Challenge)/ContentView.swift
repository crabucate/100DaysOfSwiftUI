//
//  ContentView.swift
//  Rock, Paper, Scissors (Milestone Challenge)
//
//  Created by Felix Leitenberger on 03.01.21.
//

import SwiftUI

struct ContentView: View {
    
    static let images = ["oval.fill", "paperplane.fill", "scissors"]
    
    @State private var win = Bool.random()
    @State private var selectedImageIndex = Int.random(in: 0..<3)
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text(win ? "WIN" : "LOSE")
                .font(.system(size: 80, weight: .bold))
            
            Text("against...")
                .padding()
            
            SymbolView(imageString: ContentView.images[selectedImageIndex])
            
            HStack {
                ForEach(0..<ContentView.images.count, id: \.self) { index in
                    Button {
                        evaluate(selected: index)
                    } label: {
                        SymbolView(imageString: ContentView.images[index])
                    }
                }
                .padding()
            }
            
            Text("Score: \(score)")
                .bold()
                .font(.title)
        }
    }
    
    func evaluate(selected: Int) {
        if win {
            if selected == 2 && selectedImageIndex == 0 {
                score+=1
            }
            else if selected > selectedImageIndex {
                score+=1
            } else {
                score-=1
            }
        } else {
            if selected == 2 && selectedImageIndex == 0 {
                score-=1
            }
            else if selected > selectedImageIndex {
                score-=1
            } else {
                score+=1
            }
        }
        
        win = Bool.random()
        selectedImageIndex = Int.random(in: 0..<3)
    }
}

struct SymbolView: View {
    let imageString: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.orange)
            Image(systemName: imageString)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(height: 50, alignment: .center)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
