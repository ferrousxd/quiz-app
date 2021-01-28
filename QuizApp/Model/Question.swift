//
//  Question.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 27.01.2021.
//

import Foundation

public struct Question: Codable {
    
    var questionText: String?
    var answers: [String?]
    var correctAnswer: String?
    var userAnswer: String?
}
