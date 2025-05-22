//
//  QuizResultViewController.swift
//  quizik
//
//  Created by Revolutic M1 on 22/05/2025.
//  Copyright © 2025 uvionics. All rights reserved.
//


import UIKit

class QuizResultViewController: UIViewController {

    var score: Int = 0

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quiz Completed!"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉"
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 38, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back to Home", for: .normal)
        button.backgroundColor = UIColor.systemTeal
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupLayout()
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        UIView.transition(with: scoreLabel, duration: 0.4, options: .transitionFlipFromBottom, animations: {
            self.scoreLabel.text = "Your Score: \(self.score)/10"
})
    }


    private func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        if #available(iOS 13.0, *) {
            gradient.colors = [UIColor.systemIndigo.cgColor, UIColor.systemBlue.cgColor]
        } else {
            // Fallback on earlier versions
        }
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func setupLayout() {
        [titleLabel, emojiLabel, scoreLabel, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emojiLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            scoreLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 30),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            backButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func backTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
