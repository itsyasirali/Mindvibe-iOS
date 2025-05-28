//
//  WelcomeViewController.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var startQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleStartButton()
        addGradientBackground()
    }
    
    @IBAction func handleStartButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.startQuizButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.startQuizButton.transform = CGAffineTransform.identity
            }
            let storyboard = UIStoryboard(name: .mainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: .quizCategoryViewController)
            self.navigationController?.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: false)
        })
        
        
        
    }
    private func styleStartButton() {
        startQuizButton.setTitle("🚀 Start Quiz", for: .normal)
        if #available(iOS 13.0, *) {
            startQuizButton.backgroundColor = .systemIndigo
        } else {
            startQuizButton.backgroundColor = UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1.0)
        }
        startQuizButton.setTitleColor(.white, for: .normal)
        startQuizButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        startQuizButton.layer.cornerRadius = 12
        startQuizButton.layer.shadowColor = UIColor.black.cgColor
        startQuizButton.layer.shadowOpacity = 0.25
        startQuizButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startQuizButton.layer.shadowRadius = 8
    }
    
    private func addGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}
