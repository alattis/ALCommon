//
//  ALCommonTests.swift
//  ALCommonTests
//
//  Created by andrew lattis on 2/2/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import XCTest
@testable import ALCommon

class ALCommonTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIntAbbreviation() {
        let hundred: Int = 100
        let thousand: Int = 1_000
        let million: Int = 1_000_000

        XCTAssert(hundred.abbreviatedString() == "100", "Expected 100 got \(hundred.abbreviatedString())")
        XCTAssert(thousand.abbreviatedString() == "1.0K", "Expected 1K got \(hundred.abbreviatedString())")
        XCTAssert(million.abbreviatedString() == "1.0M", "Expected 1M got \(hundred.abbreviatedString())")
    }

    func testLocalizedString() {
        let notLocalized: String = "this is not localized"
        let localizable: String = "activity.justNowLabel"
        let localized: String = "just now"

        XCTAssert(notLocalized.localized == notLocalized)
        XCTAssert(localizable.localized == localized)
    }

    func testTimestampToString() {
        let now = Int(Date().timeIntervalSince1970)

        XCTAssert(now.displayStringForTimestamp() == "activity.justNowLabel".localized)
    }

    func testNavigationViewStatusBar() {
        let viewController = LightViewController()
        let navController = UINavigationController.init(rootViewController: viewController)

        XCTAssert(navController.preferredStatusBarStyle == .lightContent)
    }
}
