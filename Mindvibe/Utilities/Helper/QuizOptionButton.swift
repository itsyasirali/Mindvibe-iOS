//
//  QuizOptionButton.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 23/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit

class QuizOptionButton: UIButton {

    var isChecked: Bool = false

    var isCorrectAnswer: Bool = false {
        didSet {
            if isCorrectAnswer {
                self.backgroundColor = Style.correctBG
            }
        }
    }

    var isInCorrectAnswer: Bool = false {
        didSet {
            if isInCorrectAnswer {
                self.backgroundColor = Style.wrongBG
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
        resetStyle()
    }

    func resetStyle() {
        isChecked = false
        isCorrectAnswer = false
        isInCorrectAnswer = false
        self.backgroundColor = Style.normalBG
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
    }

    func configure(title: String) {
        self.setTitle(title, for: .normal)
        resetStyle()
    }

    private enum Style {
        static let normalBG = UIColor.systemBlue.withAlphaComponent(0.8)
        static let correctBG = UIColor.green.withAlphaComponent(0.6)
        static let wrongBG = UIColor.red.withAlphaComponent(0.6)
    }
}
