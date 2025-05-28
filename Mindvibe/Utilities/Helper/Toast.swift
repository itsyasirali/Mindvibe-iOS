//
//  Toast.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 27/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit

struct Toast {
    static func showToast(message: String? = .empty, duration: Double = 1.5) {
        guard let vc = SceneDelegate.topRootViewController else { return }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        vc.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}
