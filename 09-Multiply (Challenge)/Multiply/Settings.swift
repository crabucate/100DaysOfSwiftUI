//
//  Settings.swift
//  Multiply
//
//  Created by Felix Leitenberger on 13.01.21.
//

import SwiftUI

struct Settings: View {
    
    @Binding var isPlaying: Bool
    @Binding var tables: [Int]
    
    @Binding var numberOfQuestions: [String]
    @Binding var numberOfQuestionsIndex: Int
    
    
    var columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]
    
    var body: some View {
        VStack {
            Text("MULTIPLY!")
                .font(.custom("Avenir", size: 60))
                .bold()
                .foregroundColor(.blue)
            Spacer()
            LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 10)
            {
                            Section(header: Text("What do you want to train?").font(.subheadline)) {
                                ForEach(1...12, id: \.self) { index in
                                    Button {
                                        if tables.contains(index) {
                                            tables.removeAll { (item) -> Bool in
                                                item == index
                                            }
                                        } else {
                                            tables.append(index)
                                        }
                                        
                                    }
                                        label: {
                                            ZStack {
                                                Circle()
                                                    .stroke()
                                                    .overlay(
                                                        Circle()
                                                        .fill(tables.contains(index) ? Color.blue : Color.clear)
                                                    )
                                                    
                                                
                                                Text("\(index)x")
                                                    .font(.title)
                                                    .foregroundColor(tables.contains(index) ? Color.white : Color.blue)
                                                    .padding()
                                            }
                                        }
                                    
                                }
                            }
                Spacer()

                            Section(header: Text("How many questions do you want to have?").font(.subheadline)) {
                                ForEach(0..<numberOfQuestions.count) { index in
                                    Button {
                                        numberOfQuestionsIndex = index
                                    }
                                        label: {
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.yellow)
                                                    .overlay(
                                                        Circle()
                                                        .fill(numberOfQuestionsIndex == index ? Color.yellow : Color.clear))
                                                    
                                                Text(numberOfQuestions[index])
                                                    .font(.title)
                                                    .foregroundColor(numberOfQuestionsIndex == index ? .white : .blue)
                                                    .padding()
                                            }
                                        }
                                }
                            }
               
        }
            Spacer()
            
            Button {
                isPlaying = true
            }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 280, height: 50, alignment: .center)
                    Text("Start")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(isPlaying: .constant(false), tables: .constant(Array(1...12)), numberOfQuestions: .constant(["10", "20", "All"]), numberOfQuestionsIndex: .constant(0))
    }
}
