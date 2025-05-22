//
//  QuizPageViewControllerCell.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import UIKit

class OnboardingStepCell: UICollectionViewCell {
    let animatedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let stepTitleLabel: UILabel = {
        let subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.text = "Steps to follow"
        subTitle.font = UIFont.boldSystemFont(ofSize: 18)
        return subTitle
    }()
    
    var stepDescriptionLabel: UILabel = {
        let step = UILabel()
        step.translatesAutoresizingMaskIntoConstraints = false
    
        step.numberOfLines = 0
        //step.sizeToFit()
        //step.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return step
    }()
    
    let submitActionButton: UIButton = {
        let submitButton = UIButton()
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = 5.0
        submitButton.backgroundColor = UIColor.green
        submitButton.setTitle("Ok, Got it", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        submitButton.isHidden = true
        return submitButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true

        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(animatedImageView)
        animatedImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        animatedImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true

        animatedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
        animatedImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(stepTitleLabel)
        stepTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        stepTitleLabel.topAnchor.constraint(equalTo: animatedImageView.bottomAnchor, constant: 40.0).isActive = true
        stepTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        addSubview(stepDescriptionLabel)
        stepDescriptionLabel.topAnchor.constraint(equalTo: stepTitleLabel.bottomAnchor, constant: 20.0).isActive = true
        
        stepDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        stepDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        addSubview(submitActionButton)
        submitActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80.0).isActive = true
        
        submitActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90.0).isActive = true
        submitActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90.0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

