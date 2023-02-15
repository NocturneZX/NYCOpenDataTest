//
//  NYCRXSchoolsTests.swift
//  NYCRXSchoolsTests
//
//  Created by Julio Reyes on 12/15/22.
//

import XCTest
import Combine
@testable import NYCRXSchools

class NYCRXSchoolsTests: XCTestCase {
    
    var mockViewModel: SchoolListViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockViewModel = SchoolListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockViewModel = nil
        try super.tearDownWithError()
    }

    func testFetchSchools() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = XCTestExpectation(description: "Fetching schools...")
        mockViewModel.$schools
            .dropFirst()
            .sink { schools in
                XCTAssertGreaterThan(schools.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        mockViewModel.fetchSchools()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchSchoolsSATs() throws { // Expect to fail. All Schools should have SAT Scores...
        let expectation = XCTestExpectation(description: "Fetching SATS Scores...")
        mockViewModel.$schools
            .dropFirst()
            .sink { schools in
                for school in schools {
                    XCTAssertNotNil(school.SATS, "All Schools should have SAT Scores...")
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        mockViewModel.fetchSchools()
        mockViewModel.fetchSATScores()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
