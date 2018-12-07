//
//  PhoneEntryControllerTests.swift
//  FirebasePhoneTests
//
//  Created by Ranjith Kumar on 11/28/18.
//  Copyright © 2018 Ranjith Kumar. All rights reserved.
//

import XCTest
@testable import FirebasePhone

class PhoneEntryControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testTitleView() {
        let phoneEntryScreen = PhoneEntryController()
        _ = phoneEntryScreen.view

        XCTAssertTrue(phoneEntryScreen.isViewLoaded)
        XCTAssertNotNil(phoneEntryScreen.navigationItem.titleView)

        let path = Bundle(for: type(of: self)).path(forResource: "country-codes", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))

        let countries = try! JSONDecoder().decode(Countries.self, from: data)
        XCTAssertTrue(countries.countries.count>0, "Countries list count is Zero")

        
    }

}
