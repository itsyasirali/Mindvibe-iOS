//
//  QuizViewController.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit
import Combine

class QuizViewController: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var optionButton1: QuizOptionButton!
    @IBOutlet weak var optionButton2: QuizOptionButton!
    @IBOutlet weak var optionButton3: QuizOptionButton!
    @IBOutlet weak var optionButton4: QuizOptionButton!

    var category_id: String!
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = QuizViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyling()
        bindViewModel()
        viewModel.fetchQuestions(for: category_id)
    }

    private func setupStyling() {
        questionText.font = .systemFont(ofSize: 22, weight: .semibold)
        questionText.textColor = .label
        questionText.numberOfLines = 0
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        buttons.forEach {
            $0?.layer.cornerRadius = 12
            $0?.setTitleColor(.white, for: .normal)
            $0?.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
            $0?.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        }
        progressView.trackTintColor = .systemGray5
        progressView.progressTintColor = .systemBlue
    }

    private func bindViewModel() {
        viewModel.$viewState
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    ActivityIndicator.show()
                    self.stackView.isHidden = true
                    self.questionText.isHidden = true
                    self.progressView.isHidden = true
                case .content:
                    ActivityIndicator.hide()
                    self.stackView.isHidden = false
                    self.questionText.isHidden = false
                    self.progressView.isHidden = false
                    self.renderQuestion()
                case .error(let message):
                    ActivityIndicator.hide()
                    Toast.showToast(message: message)
                default:
                    break
                }
            }
            .store(in: &cancellables)

        viewModel.timerTick
            .receive(on: RunLoop.main)
            .sink { [weak self] tick in
                guard let self else { return }
                self.progressView.setProgress(tick / 8.0, animated: true)
                if tick > 6.0 {
                    self.progressView.progressTintColor = UIColor.red.withAlphaComponent(0.6)
                } else {
                    self.progressView.progressTintColor = UIColor.systemBlue
                }
            }
            .store(in: &cancellables)

        viewModel.$score
            .receive(on: RunLoop.main)
            .sink { [weak self] score in
                self?.lblScore.text = "Score: \(score)"
            }
            .store(in: &cancellables)

        viewModel.$shouldNavigateToResult
            .receive(on: RunLoop.main)
            .filter { $0 }
            .sink { [weak self] _ in
                guard let self else { return }
                let storyboard = UIStoryboard(name: .mainStoryboard, bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: .quizResultViewController) as! QuizResultViewController
                resultVC.score = self.viewModel.score
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
            .store(in: &cancellables)
    }

    private func renderQuestion() {
        guard let question = viewModel.currentQuestion else { return }
        questionText.text = "Q \(viewModel.questionNumber) of \(viewModel.questionCount): \(question.decodedQuestion)"
        let options = viewModel.options
        [optionButton1, optionButton2, optionButton3, optionButton4].enumerated().forEach {
            $0.element?.configure(title: options[$0.offset])
            $0.element?.isUserInteractionEnabled = true
        }
    }

    @IBAction func optionButton1Tapped(_ sender: Any) {
        handleAnswer(optionButton1)
    }

    @IBAction func optionButton2Tapped(_ sender: Any) {
        handleAnswer(optionButton2)
    }

    @IBAction func optionButton3Tapped(_ sender: Any) {
        handleAnswer(optionButton3)
    }

    @IBAction func optionButton4Tapped(_ sender: Any) {
        handleAnswer(optionButton4)
    }

    private func handleAnswer(_ button: QuizOptionButton) {
        let selectedAnswer = button.titleLabel?.text ?? .empty
        viewModel.submitAnswer(selectedAnswer)
        [optionButton1, optionButton2, optionButton3, optionButton4].forEach {
            $0?.isUserInteractionEnabled = false
        }
        highlightCorrectAnswer(selectedAnswer: selectedAnswer)
    }

    private func highlightCorrectAnswer(selectedAnswer: String) {
        for button in [optionButton1, optionButton2, optionButton3, optionButton4] {
            guard let title = button?.titleLabel?.text else { continue }
            if title == viewModel.currentQuestion?.decodedCorrectAnswer {
                button?.isCorrectAnswer = true
            } else if title == selectedAnswer {
                button?.isInCorrectAnswer = true
            }
        }
    }
}
