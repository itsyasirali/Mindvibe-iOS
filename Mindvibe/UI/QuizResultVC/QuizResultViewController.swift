//
//  QuizResultViewController.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//
//


import UIKit

class QuizResultViewController: UIViewController {
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        backToHomeButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        scoreLabel.text = "Your Score: \(self.score)/10"
    }
    
    private func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        if #available(iOS 13.0, *) {
            gradient.colors = [UIColor.systemIndigo.cgColor, UIColor.systemBlue.cgColor]
        } else {
            gradient.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor]
        }
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
