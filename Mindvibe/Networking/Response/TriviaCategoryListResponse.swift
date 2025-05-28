//
//  TriviaCategoryListResponse.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Foundation

struct TriviaCategoryListResponse: Codable {
    let categories: [TriviaCategory]?

    enum CodingKeys: String, CodingKey {
        case categories = "trivia_categories"
    }
}

struct TriviaCategory: Codable {
    let id: Int?
    let name: String?
}

