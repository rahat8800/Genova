//
//  GenovaTests.swift
//  GenovaTests
//
//  Created by Rahat on 29/02/24.
//

import XCTest
@testable import Genova


final class GenovaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func loadDataFromJSONFile<T: Decodable>(fileName: String) -> [T]? {
        // Get the file URL for the JSON file
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            // Read data from the file
            let jsonData = try Data(contentsOf: fileURL)
            
            // Parse JSON data into an array of objects of type T
            return try JSONDecoder().decode([T].self, from: jsonData)
            
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
    func testLoadingValidJSONFile() {
            // Arrange
            let fileName = "DataModel"
            
            // Act
            let result: [Product]? = loadDataFromJSONFile(fileName: fileName)
            
            // Assert
            XCTAssertNotNil(result, "Data should not be nil")
            XCTAssertEqual(result?.count, 30, "Unexpected number of objects")
            // Add more assertions as needed based on your object type and data
        }
        
        func testLoadingInvalidJSONFile() {
            // Arrange
            let fileName = "invalidData"
            
            // Act
            let result: [Product]? = loadDataFromJSONFile(fileName: fileName)
            
            // Assert
            XCTAssertNil(result, "Data should be nil due to invalid JSON")
            // Add more assertions as needed based on your object type and data
        }
        
        func testLoadingNonExistentJSONFile() {
            // Arrange
            let fileName = "nonExistent"
            
            // Act
            let result: [Product]? = loadDataFromJSONFile(fileName: fileName)
            
            // Assert
            XCTAssertNil(result, "Data should be nil as file does not exist")
        }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
