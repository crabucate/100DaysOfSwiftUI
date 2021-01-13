//
//  ContentView.swift
//  Flags
//
//  Created by Felix Leitenberger on 01.01.21.
//

import SwiftUI


// Day 24: Go back to project 2 and create a Flag-View that renders one flag image using the specific set of modifiers we had.

struct Flag: View {
    
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var score = 0
    @State private var rotationAngles = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var shakes = [0, 0 ,0]
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                Spacer()
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Flag(country: self.countries[number])
                            .rotation3DEffect(Angle(degrees: rotationAngles[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(opacities[number])
                            .animation(.default)
                            .modifier(ShakeEffect(shakes: shakes[number]))
                    }
                }
                
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Spacer()
            }
            
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            rotationAngles[number] += 360
            opacities = [0.25, 0.25, 0.25]
            opacities[number] = 1.0
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)."
        } else {
            withAnimation(.linear) {
                shakes[number] = 3
            }
            scoreTitle = "Wrong"
            scoreMessage = "This is the flag of \(countries[number])"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            showingScore = true
        })
        
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacities = [1.0, 1.0, 1.0]
        shakes = [0, 0, 0]
    }
}


struct ShakeEffect: GeometryEffect {
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
