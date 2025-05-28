//
//  ActivityIndicator.swift
//  Mindvibe
//
//  Created by Revolutic M1 on 27/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//


import UIKit
import ProgressHUD

class ActivityIndicator {
    private init() {}
    
    class func setup() {
        ProgressHUD.colorHUD = UIColor(named: "primary")!
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorAnimation = UIColor(named: "primary")!
        ProgressHUD.colorStatus = UIColor(named: "primary")!
    }
    
    class func show() {
        ProgressHUD.show(interaction: false)
    }
    
    class func hide() {
        ProgressHUD.dismiss()
    }
}
