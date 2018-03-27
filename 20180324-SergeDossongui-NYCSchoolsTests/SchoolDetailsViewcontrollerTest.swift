//
//  SchoolDetailsViewcontrollerTest.swift
//  20180324-SergeDossongui-NYCSchoolsTests
//
//  Created by serge kone Dossongui on 3/26/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import XCTest
@testable import _0180324_SergeDossongui_NYCSchools

class SchoolDetailsViewcontrollerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
 

    
   func testFormatWebsite() {
    
    let vc = SchoolDetailsViewController()
    let webString = "www.yahoo.fr"
    let FormatedWebsite = "http://www.yahoo.fr"
    let resultWebsite = vc.formatWebsite(website: webString as NSString)
    
    XCTAssertEqual(resultWebsite as String, FormatedWebsite)
 
    
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
