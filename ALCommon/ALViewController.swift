//
//  ALViewController.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    /// Present a confirmation alert, and place a call to a given number if it passes some very basic input validation
    ///
    /// - Parameter phoneNumber: Phone number to call
    internal func call(phoneNumber: String?) {
        guard let phoneNumber = phoneNumber else { return }

        let validCharacters: Set<Character> = Set("0123456789".characters)
        let cleanPhoneNumber = String(phoneNumber.characters.filter({validCharacters.contains($0)}))

        guard cleanPhoneNumber.characters.count > 0 else { return }

        let alert = UIAlertController.init(title: phoneNumber, message: nil, preferredStyle: .alert)

        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let call = UIAlertAction.init(title: "Call", style: .default) { (_) in
            if let numberURL = URL(string:"tel://\(cleanPhoneNumber)") {
                UIApplication.shared.open(numberURL, options: [:], completionHandler: nil)
            }
        }

        alert.addAction(cancel)
        alert.addAction(call)

        self.present(alert, animated: true, completion: nil)
    }

    /// Open the Maps app to a given street address, assuming the input street is valid, no validation occurs prior to passing this to maps
    ///
    /// - Parameter address: Street address to map
    internal func route(address: String) {
        let directions = "http://maps.apple.com?daddr=\(address.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)"
        if let directionsUrl = URL(string: directions) {
            UIApplication.shared.open(directionsUrl, options: [:], completionHandler: nil)
        }
    }

    /// Present a new Safari View Controller to a given http/https url, very basic validation occurs before opening SVC
    ///
    /// - Parameter urlString: A url to open, must begin with http
    internal func open(url urlString: String?) {
        //safari "helpfully" throws an exception if you pass it a url that isn't http or https
        guard let urlString = urlString, urlString.lowercased().hasPrefix("http") == true else { return }

        if let url = URL.init(string: urlString) {
            let safariViewController = SFSafariViewController.init(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        }
    }

}
