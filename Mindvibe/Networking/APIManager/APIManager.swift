//
//  APIManager.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 27/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Alamofire
import Combine
import Foundation

final class APIManager {
    static func request<T: Decodable>(_ url: URL, type: T.Type) -> AnyPublisher<T, APIError> {
        AF.request(url)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .mapError { error in
                if let afError = error.asAFError {
                    switch afError {
                    case .responseSerializationFailed(reason: .decodingFailed):
                        return .decodingError
                    case .responseValidationFailed(let reason):
                        return .validationError(String(describing: reason))
                    default:
                        return .networkError(afError.localizedDescription)
                    }
                }
                return .unknown(error)
            }
            .eraseToAnyPublisher()
    }
}
