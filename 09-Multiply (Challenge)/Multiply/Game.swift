//
//  Game.swift
//  Multiply
//
//  Created by Felix Leitenberger on 13.01.21.
//

import SwiftUI
import Introspect

struct Game: View {
    
    @Binding var isPlaying: Bool
    @Binding var tables: [Int]
    
    @Binding var numberOfQuestions: [String]
    @Binding var numberOfQuestionsIndex: Int
    
    @State private var questions = [Question(text: "Loading", answer: 0)]
    @State private var currentQuestionIndex = 0
    
    @State private var textFieldInput = ""
    @State private var borderColorTextField = Color.blue
    @State private var backgroundColorTextField = Color.clear
    
    var body: some View {
        
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: .none, height: 150, alignment: .center)
                        .padding()
                Text(questions[currentQuestionIndex].text)
                    .font(.custom("Avenir", size: 70))
                    .bold()
                }
                TextField("", text: $textFieldInput)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColorTextField, lineWidth: 3)
                                .background(backgroundColorTextField
                                                .cornerRadius(10)
                                )
                                .padding())
                    .font(.custom("Avenir", size: 70))
                    
                    .frame(height: 200, alignment: .center)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    
                    
                    .introspectTextField { textField in
                        textField.becomeFirstResponder()
                    }
                    
                Button {
                    borderColorTextField = questions[currentQuestionIndex].answer == Int(textFieldInput) ?? 0 ? Color.green : Color.red
                    backgroundColorTextField = questions[currentQuestionIndex].answer == Int(textFieldInput) ?? 0 ? Color.green : Color.red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        textFieldInput = ""
                        borderColorTextField = .gray
                        backgroundColorTextField = .clear
                        
                        if currentQuestionIndex + 1 < questions.count {
                            currentQuestionIndex += 1
                        } else {
                            isPlaying = false
                        }
                    }
                    
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 280, height: 50, alignment: .center)
                        Text("Submit")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                }
            }
            .onAppear(perform: {
                questions = Question.generateQuestions(tables: tables, numberOfQuestions: numberOfQuestions[numberOfQuestionsIndex])
            })
        }
        
        
    }


struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game(isPlaying: .constant(true), tables: .constant([1]), numberOfQuestions: .constant(["10", "20"]), numberOfQuestionsIndex: .constant(0))
    }
}
