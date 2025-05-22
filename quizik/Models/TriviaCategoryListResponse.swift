//
//  TriviaCategoryListResponse.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import Foundation

struct TriviaCategoryListResponse : Codable {
    let categories : [TriviaCategory]?

    enum CodingKeys: String, CodingKey {
        case categories = "trivia_categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([TriviaCategory].self, forKey: .categories)
    }

}

struct TriviaCategory : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id
        case name
    }

    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            name = try values.decodeIfPresent(String.self, forKey: .name)
   }

}
