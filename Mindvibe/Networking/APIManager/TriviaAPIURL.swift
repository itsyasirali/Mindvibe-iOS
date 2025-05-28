//
//  TriviaAPIURL.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Foundation

struct TriviaAPIURL {
    static let baseURL = "https://opentdb.com/api.php"
    static let categoryURL = URL(string: "https://opentdb.com/api_category.php")
    
    static func questionURL(
        amount: Int = 10,
        categoryID: String,
        difficulty: QuizDifficulty = .easy,
        type: QuestionType = .multipleChoice
    ) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "amount", value: "\(amount)"),
            URLQueryItem(name: "category", value: categoryID),
            URLQueryItem(name: "difficulty", value: difficulty.rawValue),
            URLQueryItem(name: "type", value: type.rawValue)
        ]
        return components?.url
    }

}
