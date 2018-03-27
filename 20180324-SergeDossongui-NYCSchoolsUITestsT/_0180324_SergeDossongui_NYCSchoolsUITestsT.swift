//
//  _0180324_SergeDossongui_NYCSchoolsUITestsT.swift
//  20180324-SergeDossongui-NYCSchoolsUITestsT
//
//  Created by serge kone Dossongui on 3/26/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import XCTest

class _0180324_SergeDossongui_NYCSchoolsUITestsT: XCTestCase {
    
   
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableInterraction() {
        
        let app = XCUIApplication()
       
       
        // Assert that we are displaying the tableview
        let HomeTableView = app.tables["Home--TableView"]
        XCTAssertTrue(HomeTableView.exists, "The Home--TableView exists")

        
        
        // Get an array of cells asssert NUmber of cell is the same as number of Row from APi
        let tableCells = HomeTableView.cells
        print("Count of table cells \(tableCells.count)")
        XCTAssertEqual(tableCells.count, RowNYCSchoolCount)
            
        
        
        //Itterate throw each Row and assert it s moving to next screen
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
               
                // Assert that selecting Cell  take us to the next screen
                tableCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
        
  
    
    }
    
}
