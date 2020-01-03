//
//  iosTests.swift
//  iosTests
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import XCTest
@testable import ios

class iosTests: XCTestCase {

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
    
    class MyObject {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    func testMyObjectsEqual() {
        let myObject = MyObject(name: "obj1")
        let myOtherObject = MyObject(name: "obj1")
        let otherReferenceToMyFirstObject = myObject
        //XCTAssert(myObject === myOtherObject) // fails
        XCTAssert(myObject === otherReferenceToMyFirstObject) // passes
    }

}
