//
//  ContentView.swift
//  Dice
//
//  Created by Felix Leitenberger on 12.04.21.
//

import SwiftUI

struct ContentView: View {

    @State private var number: Int = Int.random(in: 1...6)
    @State private var isRolling = false

    var body: some View {
        VStack {
            Dice(number: number, size: 300)
            Button(action: { rollTheDice()}) {
                Text(isRolling ? "Rolling..." : "Roll the dice")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .overlay(
                        Capsule()
                            .stroke(Color.black, lineWidth: 5)
                    )
            }
            .disabled(isRolling)
        }
    }


    func rollTheDice() {
print("Setting is Rolling to true")
        print(isRolling)
        isRolling = true

        for breaktime in 1...10 {
            let breakTimeDobule = Double(breaktime) / 3
            DispatchQueue.main.asyncAfter(deadline: .now() + breakTimeDobule) {
                withAnimation {
                    number = Int.random(in: 1...6)
                }

                print(breaktime)
                print(isRolling)
                if breaktime == 10 {
                    isRolling = false
                }
        }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
