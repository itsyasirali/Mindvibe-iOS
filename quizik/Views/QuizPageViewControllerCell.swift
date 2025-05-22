//
//  QuizPageViewControllerCell.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import UIKit

class QuizPageViewControllerCell: UICollectionViewCell {
    let gifView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageview : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.text = "Steps to follow"
        subTitle.font = UIFont.boldSystemFont(ofSize: 18)
        return subTitle
    }()
    
    var step: UILabel = {
        let step = UILabel()
        step.translatesAutoresizingMaskIntoConstraints = false
    
        step.numberOfLines = 0
        //step.sizeToFit()
        //step.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return step
    }()
    
    let submitButton: UIButton = {
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
        
        addSubview(imageview)
        imageview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        imageview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true

        imageview.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(gifView)
        gifView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        gifView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true

        gifView.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
        gifView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(subTitle)
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        subTitle.topAnchor.constraint(equalTo: gifView.bottomAnchor, constant: 40.0).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        addSubview(step)
        step.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20.0).isActive = true
        
        step.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        step.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        addSubview(submitButton)
        submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80.0).isActive = true
        
        submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90.0).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90.0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

