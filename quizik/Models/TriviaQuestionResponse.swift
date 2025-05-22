//
//  OpenTriviaResponse.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import Foundation
struct TriviaQuestionResponse : Codable {
	let responseCode : Int?
	let questions : [TriviaQuestion]?

	enum CodingKeys: String, CodingKey {

		case responseCode = "response_code"
		case questions = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        questions = try values.decodeIfPresent([TriviaQuestion].self, forKey: .questions)
	}

}

struct TriviaQuestion : Codable {
    let category : String?
    let type : String?
    let difficulty : String?
    let question : String?
    let correct_answer : String?
    let incorrect_answers : [String]?

    enum CodingKeys: String, CodingKey {

        case category
        case type
        case difficulty
        case question
        case correct_answer = "correct_answer"
        case incorrect_answers = "incorrect_answers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        correct_answer = try values.decodeIfPresent(String.self, forKey: .correct_answer)
        incorrect_answers = try values.decodeIfPresent([String].self, forKey: .incorrect_answers)
    }

}
