//
//  ALTextField.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import UIKit

extension UITextField {
    /// Shake the view to get the users attention if a required value is missing or invalid
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: { () -> Void in
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
