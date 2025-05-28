//
//  String.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 23/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Foundation

extension String {
    static var quizCategoryViewController = "QuizCategoryViewController"
    static var quizResultViewController = "QuizResultViewController"
    static var quizViewController = "QuizViewController"
    static var mainStoryboard = "Main"
    static var invalidURL = "Invalid URL"
    static var noCategoriesFound = "No categories found."
    static var cellIdentifier = "proCell"
    static var timeExpired = "TimeExpired"
    static var empty = ""
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
