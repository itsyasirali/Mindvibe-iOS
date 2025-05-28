//
//  enum.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 27/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Foundation

enum QuizDifficulty : String {
    case any = ""
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

enum QuestionType : String {
    case any = ""
    case multipleChoice = "multiple"
    case trueFalse = "boolean"
}

enum ViewState {
    case initial
    case loading
    case content
    case empty
    case error(String)
}

enum APIError: Error {
    case decodingError
    case validationError(String)
    case networkError(String)
    case invalidURL
    case unknown(Error)

    var message: String {
        switch self {
        case .decodingError: return "Failed to decode response."
        case .validationError(let msg): return msg
        case .networkError(let msg): return msg
        case .invalidURL: return .invalidURL
        case .unknown(let err): return err.localizedDescription
        }
    }
}
