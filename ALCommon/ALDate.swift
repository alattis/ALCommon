//
//  ALDate.swift
//  ALCommon
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import Foundation

extension Int {
    /// Converts a Unix Timestamp Integer into a display ready String
    ///
    /// - Returns: String describe how recently an activity occured
    func displayStringForTimestamp () -> String {

        let nowTimestamp = Int(Date().timeIntervalSince1970)
        let timeDifference = nowTimestamp - self

        if timeDifference < 60 {
            return "activity.justNowLabel".localized
        } else if timeDifference < 3600 {
            return String.localizedStringWithFormat("activity.minutesAgoLabel".localized, timeDifference/60)
        } else if timeDifference < 7200 {
            return "activity.oneHourAgoLabel".localized
        } else if timeDifference < 86400 {
            return String.localizedStringWithFormat("activity.hoursAgoLabel".localized, (timeDifference/60)/60)
        } else if timeDifference < 86400*2 {
            return "activity.oneDayAgoLabel".localized
        } else {
            return String.localizedStringWithFormat("activity.daysAgoLabel".localized, ((timeDifference/60)/60)/24)
        }

    }

}
