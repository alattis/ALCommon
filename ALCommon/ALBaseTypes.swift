//
//  ALBaseTypes.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import Foundation

extension String {
    ///NSLocalizedString value of self
    var localized: String! {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }
}

extension Int {
    /// Abbreviate the current integer, 1000 becomes 1K, 1,000,000 becomes 1M
    ///
    /// - Returns: A String ready for display
    func abbreviatedString () -> String {
        var numberString: String = ""
        if self < 1000 {
            numberString = String(self)
        } else if self < 1000000 {
            let newNumber = Float(self) / 1000.0
            numberString = String(format: "%.1fK", newNumber)
        } else {
            let newNumber = Float(self) / 1000000.0
            numberString = String(format: "%.1fM", newNumber)
        }

        return numberString
    }
}
