//
//  TriviaQuestionResponse.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//
//


import Foundation

struct TriviaQuestionResponse: Codable {
    let responseCode: Int?
    let questions: [TriviaQuestion]?

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case questions = "results"
    }
}

struct TriviaQuestion: Codable {
    let category: String?
    let type: String?
    let difficulty: String?
    let question: String?
    let correct_answer: String?
    let incorrect_answers: [String]?

    var decodedQuestion: String {
        question?.htmlDecoded ?? .empty
    }

    var decodedCorrectAnswer: String {
        correct_answer?.htmlDecoded ?? .empty
    }

    var decodedIncorrectAnswers: [String] {
        incorrect_answers?.map { $0.htmlDecoded } ?? []
    }
}
