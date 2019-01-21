//
//  Alert.swift
//  Movie
//
//  Created by Phạm Xuân Tiến on 1/12/19.
//  Copyright © 2019 Framgia. All rights reserved.
//

import Foundation
import SCLAlertView
import Toaster

struct Alert {
    static func showError(_ text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let appearance = SCLAlertView.SCLAppearance(
                hideWhenBackgroundViewIsTapped: true
            )
            let alert = SCLAlertView(appearance: appearance)
            alert.showError("Error", subTitle: text)
        }
    }
    
    static func showToast(_ text: String) {
        Toast(text: text, duration: Delay.short).show()
    }
}
