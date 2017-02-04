//
//  ALNavigation.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import UIKit

extension UINavigationController {
    /// Pass the message on to the child view controller
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
