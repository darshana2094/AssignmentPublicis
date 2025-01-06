//
//  UserListUITest.swift
//  AssignmentPublicisUITests
//
//  Created by Darshana Nagekar on 06/01/25.
//

import XCTest
import Combine
import SwiftUI
@testable import AssignmentPublicis


final class UserListUITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_UserListView_ProgressIndicator_Visible() throws {
    
                
//        //Given
    let activityIndicatorScreen =  app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //When
        activityIndicatorScreen.tap()
        
        //Then
        XCTAssertTrue(activityIndicatorScreen.exists)
        
    }
    
    func test_UserLisView_NavigationBar_Exists() throws {
        
        //Given
        let userListNavigationBar = XCUIApplication().navigationBars["USER LIST"].staticTexts["USER LIST"]
        
        //When
        userListNavigationBar.tap()
        
        //Then
        XCTAssertTrue(userListNavigationBar.exists)
    }
    
    func test_UserListView_Scrolling_Performance() throws {
        
        measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric]) {
            app.swipeUp()
            app.swipeDown()
        }
     
    }
    
    func test_UserListView_WhenLoadedWithData() throws {
        
        //Given
        let userlistviewCollectionView = app.collectionViews["UserListView"]
        let userCardView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let userListButton = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["USER LIST"]
        
        //When
        userlistviewCollectionView/*@START_MENU_TOKEN@*/.staticTexts["# 1 Leanne Graham"]/*[[".cells",".buttons[\"# 1 Leanne Graham, Sincere@april.biz, Gwenborough\"].staticTexts[\"# 1 Leanne Graham\"]",".buttons[\"UserCell-1-UserCell-1-UserCell-1-UserCell-1-UserCell-1\"].staticTexts[\"# 1 Leanne Graham\"]",".staticTexts[\"# 1 Leanne Graham\"]"],[[[-1,3],[-1,2],[-1,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        userCardView.tap()
        userListButton.tap()
       
        //Then
        XCTAssertTrue(userCardView.exists)
        
    }
    
//    func test_UserListView_NoInternetConnectionView() throws {
//        
//        //Given
//        let checkYourInternetConnectionStaticText = app.staticTexts["Check your internet connection"]
//        let pleaseCheckYourConnection =  app.staticTexts["Please check your connection."]
//        let refreshButton =  app.buttons["Refresh"]
//        
//        //When
//        checkYourInternetConnectionStaticText.tap()
//        checkYourInternetConnectionStaticText.tap()
//        pleaseCheckYourConnection.tap()
//        refreshButton.tap()
//        
//        //Then
//        XCTAssertTrue(refreshButton.exists)
//    }
    
//    func test_UserListView_SomethingWentWrongView() throws {
//                                       
//
//        let somethingWentWrongStaticText = app.staticTexts["Something Went Wrong"]
//        let pleaseTryAgain =   app.staticTexts["Please try again."]
//        let refreshButton =  app.buttons["Refresh"]
//        
//        somethingWentWrongStaticText.tap()
//                somethingWentWrongStaticText.tap()
//        pleaseTryAgain.tap()
//        refreshButton.tap()
//        
//        XCTAssertTrue(refreshButton.exists)
//    }
    
}

