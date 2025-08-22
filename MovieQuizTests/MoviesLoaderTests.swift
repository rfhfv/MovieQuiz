//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by admin on 17.08.2025.
//

import XCTest
@testable import MovieQuiz

class MoviesLoaderTests: XCTestCase {
    func testSuccessLoading() throws {
        // Given
        let stubNetworkCLient = StubNetworkClient(enumlateError: false)
        let loader = MoviesLoader()
        
        // When
        let expectation = expectation(description: "Loading expectation")
        
        // Then
        loader.loadMovies { result in
            switch result {
            case .success(let movies):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
            }
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFailureLoading() throws {
        // Given
        let stubNetworkClient = StubNetworkClient(enumlateError: true)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        // When
        let expectation = expectation(description: "Loading expestation")
        
        // Then
        loader.loadMovies { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected failure")
            case .failure(let error):
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }
}
