//
//  Question.swift
//  Multiply
//
//  Created by Felix Leitenberger on 13.01.21.
//

import Foundation

struct Question {
    var text: String
    var answer: Int

    
    static func generateQuestions(tables: [Int], numberOfQuestions: String) -> [Question] {
        let firstNumbers = tables
        let secondNumbers = Array(1...12)
        var questions = [Question]()
        
        for firstNumber in firstNumbers {
            for secondNumber in secondNumbers {
                let questionText = "\(firstNumber) x \(secondNumber)"
                let answer = firstNumber * secondNumber
                questions.append(Question(text: questionText, answer: answer))
            }
        }
        
        if numberOfQuestions == "all" {
            return questions.shuffled()
        } else if numberOfQuestions == "20" {
            return Array(questions.shuffled()[0..<20])
        } else {
            return Array(questions.shuffled()[0..<10])
        }
    }
}
