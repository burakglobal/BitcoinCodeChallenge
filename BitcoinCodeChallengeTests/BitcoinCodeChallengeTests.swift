//
//  BitcoinCodeChallengeTests.swift
//  BitcoinCodeChallengeTests
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import XCTest
@testable import BitcoinCodeChallenge

class BitcoinCodeChallengeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
    }

    func testHomeModel() {

        var homeModel = [HomeModel]()
        homeModel = HomeModel.modelsFromDictionaryArray()
        XCTAssertEqual(homeModel.count, 5)

    }

    func testPerformanceExample() {
        self.measure {
        }
    }
}
