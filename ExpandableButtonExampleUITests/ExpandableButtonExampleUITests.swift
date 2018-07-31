//
//  ExpandableButtonExampleUITests.swift
//  ExpandableButtonExampleUITests
//
//  Created by Dima Mishchenko on 31.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import XCTest

class ExpandableButtonExampleUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testOpenOnTap() {
        
        app.launch()
        
        let button = app.otherElements["expandableButton"].children(matching: .button).element(boundBy: 0)
        
        XCTAssert(button.exists)
        XCTAssert(app.buttons.count == 1)
        
        button.tap()

        XCTAssert(app.buttons.count == 5)
    }
    
    func testCloseOnTap() {
        
        app.launch()
        
        let button = app.otherElements["expandableButton"].children(matching: .button).element(boundBy: 0)
        
        XCTAssert(app.buttons.count == 1)
        
        button.tap()
        XCTAssert(app.buttons.count != 1)
        

        button.tap()
        XCTAssert(app.buttons.count == 1)
    }
    
}
