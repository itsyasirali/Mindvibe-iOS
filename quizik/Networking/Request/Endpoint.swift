//
//  Endpoint.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

//import Foundation
//
//public typealias HTTPHeaders = [String:String]
//
//enum HTTPMethod: String {
//    case get        = "GET"
//    case post       = "POST"
//    case put        = "PUT"
//    case delete     = "DELETE"
//    case patch      = "PATCH"
//    case head       = "HEAD"
//    case trace      = "TRACE"
//    case connect    = "CONNECT"
//    case options    = "OPTIONS"
//}
//
//public struct Endpoint {
//    var path: String
//    var httpMethod: HTTPMethod
//    var headers: HTTPHeaders?
//    var body: Data?
//    var queryItems: [URLQueryItem]?
//}
//
//// MARK: - Request Setup
//
//extension Endpoint {
//    
//    var urlComponents: URLComponents {
//        let base: String = BASE_URL
//        var component = URLComponents(string: base)!
//        component.path = path
//        
//        if let _ = queryItems{
//            if queryItems!.count > 0{
//                component.queryItems = queryItems
//            }
//        }
//       
//        return component
//    }
//    
//    var request: URLRequest {
//        var request = URLRequest(url: urlComponents.url!)
//        request.httpMethod  = httpMethod.rawValue
//        request.httpBody    = body
//        if  let headers = headers {
//            for(headerField, headerValue) in headers {
//                request.setValue(headerValue, forHTTPHeaderField: headerField)
//            }
//        }
//        request.httpShouldHandleCookies = true
//        return request
//    }
//}
