//
//  QuizCategoryCollectionViewCell.swift
//  Mindvibe
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit

class QuizCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCardStyle()
        configureUI()
        animateEntrance()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        iconImageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .black
        }
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    override var isHighlighted: Bool {
        didSet {
            let scale: CGFloat = isHighlighted ? 0.96 : 1.0
            let shadowOpacity: Float = isHighlighted ? 0.2 : 0.08
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.layer.shadowOpacity = shadowOpacity
            }, completion: nil)
        }
    }

    private func animateEntrance() {
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 0.4, delay: 0.05, options: [.curveEaseOut], animations: {
            self.alpha = 1
            self.transform = .identity
        }, completion: nil)
    }
}


extension UICollectionViewCell {
    func applyCardStyle() {
        let radius: CGFloat = 16
        contentView.layer.cornerRadius = radius
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.6
        if #available(iOS 13.0, *) {
            contentView.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            contentView.layer.borderColor = UIColor.black.cgColor
        }

        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 12
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        backgroundColor = .clear
    }
}

