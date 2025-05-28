//
//  QuizViewModel.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//
//


import Foundation
import Combine

final class QuizViewModel {
    @Published var viewState: ViewState = .initial
    @Published var currentQuestion: TriviaQuestion?
    @Published var options: [String] = []
    @Published var score: Int = 0
    @Published var progress: Float = 0.0
    @Published var shouldNavigateToResult = false
    
    var questionCount: Int { allQuestions.count }
    var questionNumber: Int { currentIndex + 1 }
    private var allQuestions: [TriviaQuestion] = []
    private var currentIndex = 0
    private var correctAnswer: String = .empty
    private var cancellables = Set<AnyCancellable>()
    var timer: Timer?
    var timerTick = CurrentValueSubject<Float, Never>(0.0)
    
    func fetchQuestions(for categoryID: String) {
        guard let url = TriviaAPIURL.questionURL(categoryID: categoryID) else {
            viewState = .error(.invalidURL)
            return
        }
        viewState = .loading
        APIManager.request(url, type: TriviaQuestionResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.viewState = .error(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                if response.responseCode != 0 || response.questions?.isEmpty ?? true {
                    viewState = .error("No valid questions returned.")
                    return
                }
                self.allQuestions = response.questions ?? []
                self.startQuiz()
            })
            .store(in: &cancellables)
    }
    
    func startQuiz() {
        score = 0
        currentIndex = 0
        loadCurrentQuestion()
    }
    
    private func loadCurrentQuestion() {
        guard currentIndex < allQuestions.count else {
            shouldNavigateToResult = true
            return
        }
        let question = allQuestions[currentIndex]
        currentQuestion = question
        correctAnswer = question.decodedCorrectAnswer
        var answers = [correctAnswer] + (question.decodedIncorrectAnswers)
        answers.shuffle()
        options = answers
        viewState = .content
        startTimer()
    }
    
    func submitAnswer(_ answer: String) {
        timer?.invalidate()
        if answer == correctAnswer {
            score += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.currentIndex += 1
            self.loadCurrentQuestion()
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timerTick.send(0.0)
        var elapsed: Float = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] t in
            guard let self else { return }
            elapsed += 0.01
            self.timerTick.send(elapsed)
            if elapsed >= 8.0 {
                t.invalidate()
                self.submitAnswer(.timeExpired)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
