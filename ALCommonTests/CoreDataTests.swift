//
//  CoreDataTests.swift
//  ALCommon
//
//  Created by andrew lattis on 2/4/17.
//  Copyright © 2017 andrew lattis. All rights reserved.
//

import XCTest
@testable import ALCommon

class CoreDataTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let privateContext = DataManager.sharedManager.backgroundContext

        privateContext.perform {
            let dataObject = SomeData(context:privateContext)
            dataObject.id = 1
            dataObject.updatedAt = Int64(Int(Date().timeIntervalSince1970))

            try? privateContext.save()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUpdatedAt() {
        let context = DataManager.sharedManager.viewContext
        let noDataTimestamp = NoData.timestampOfNewestObject(inContext: context)
        let someDataTimestamp = SomeData.timestampOfNewestObject(inContext: context)

        XCTAssert(noDataTimestamp == 0)
        XCTAssert(someDataTimestamp > 0)
    }

    func testFetchById() {
        let context = DataManager.sharedManager.viewContext

        let someDataObject = SomeData.fetchObject(withId: 1, inContext: context)
        let noDataObject = NoData.fetchObject(withId: 1, inContext: context)

        XCTAssert(someDataObject != nil)
        XCTAssert(noDataObject == nil)
    }
}
