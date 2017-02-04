//
//  ALView.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import UIKit

extension UIView {
    /// Add a blur effect to the full size of the view
    ///
    /// - Parameter type: Blur effect style to apply
    func addBlur(ofType type: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect.init(style: type)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(visualEffectView, at:0)

        let topConstraint = NSLayoutConstraint.init(item: visualEffectView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint.init(item: visualEffectView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint.init(item: visualEffectView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint.init(item: visualEffectView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}
