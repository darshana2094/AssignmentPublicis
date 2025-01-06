//
//  UserDetailsCardUITest.swift
//  AssignmentPublicisUITests
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest

final class UserDetailsCardUITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UserDetailCard() throws {
        
        //Given
        let userCell = app.collectionViews["UserListView"]/*@START_MENU_TOKEN@*/.staticTexts["Sincere@april.biz"]/*[[".cells",".buttons[\"# 1 Leanne Graham, Sincere@april.biz, Gwenborough\"].staticTexts[\"Sincere@april.biz\"]",".buttons[\"UserCell-1-UserCell-1-UserCell-1-UserCell-1-UserCell-1\"].staticTexts[\"Sincere@april.biz\"]",".staticTexts[\"Sincere@april.biz\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let userCard = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let nameStaticText =  app.staticTexts["Name:"]
        let nameText =  app.staticTexts["Leanne Graham"]
        let emailStaticText = app.staticTexts["Email:"]
        let emailText =   app.staticTexts["Sincere@april.biz"]
        let addressStaticText =  app.staticTexts["Address:"]
        let addressText =  app.staticTexts["Kulas Light, Gwenborough, 92998-3874"]
        let companyStaticText =  app.staticTexts["Company:"]
        let companyText = app.staticTexts["Romaguera-Crona"]
        
        //When
        userCell.tap()
        userCard.tap()
        nameStaticText.tap()
        nameText.tap()
        emailStaticText.tap()
        emailText.tap()
        addressStaticText.tap()
        addressText.tap()
        companyStaticText.tap()
        companyText.tap()
        
        //Then
        XCTAssertTrue(userCard.exists)
        
    }
}
