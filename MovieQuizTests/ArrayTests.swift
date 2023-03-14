//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Margarita Pitinova on 09.03.2023.
//

import Foundation
import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]
        
        // When
        let value: Int? = array[safe: 2]
        
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    func testGetValieOfRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]
        
        // When
        let value: Int? = array[safe: 20]
        
        //Then
        XCTAssertNil(value)
    }
    
}
