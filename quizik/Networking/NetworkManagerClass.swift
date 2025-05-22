//
//  NetworkManagerClass.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import Foundation

class NetworkManagerClass{
    func fetchQuizBloc(difficulty: String, category: String, type: String, completionHandler: @escaping ([Results]) -> Void) {
        let full_url = URL(string: url + "amount=10" +  "&category=\(category)&difficulty=\(difficulty)&type=\(type)")!
        
        
      let task = URLSession.shared.dataTask(with: full_url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching quiz data: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }

        if let data = data,
          let openTriviaResponse = try? JSONDecoder().decode(OpenTriviaResponse.self, from: data) {
            completionHandler(openTriviaResponse.results ?? [])
        }
      })
      task.resume()
    }
    
    func fetchCategories(completionHandler: @escaping ([TriviaCategory]) -> Void) {
        let full_url = URL(string: category_url)!
        
        
      let task = URLSession.shared.dataTask(with: full_url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching quiz data: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }

        if let data = data,
          let openTriviaCategoryResponse = try? JSONDecoder().decode(TriviaCategoryListResponse.self, from: data) {
            completionHandler(openTriviaCategoryResponse.categories ?? [])
        }
      })
      task.resume()
    }
    
}

enum Response_Codes : String {
    case Success = "Returned results successfully"
    case No_Results = "Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)"
    case Invalid_Parameter = "Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)"
    case Token_Not_Found = "Session Token does not exist."
    case Token_Empty = "Session Token has returned all possible questions for the specified query. Resetting the Token is necessary."
}
