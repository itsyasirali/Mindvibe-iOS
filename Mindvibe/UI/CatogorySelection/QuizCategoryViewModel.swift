//
//  QuizCategoryViewModel.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import Foundation
import Combine

final class QuizCategoryViewModel {
    
    @Published var categories: [TriviaCategory] = []
    @Published var state: ViewState = .initial

    private var cancellables = Set<AnyCancellable>()

    func fetchCategories() {
        guard let url = TriviaAPIURL.categoryURL else {
            state = .error(.invalidURL)
            return
        }

        state = .loading

        APIManager.request(url, type: TriviaCategoryListResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.categories = response.categories ?? []
                self.state = self.categories.isEmpty ? .empty : .content
            })
            .store(in: &cancellables)
    }
}
