//
//  Result.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    case success(T)
    case failure(E)
}
