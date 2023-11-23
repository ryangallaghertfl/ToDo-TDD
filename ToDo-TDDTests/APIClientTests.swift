//
//  APIClientTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//
import XCTest
@testable import ToDo_TDD

final class APIClientTests: XCTestCase {
    
    var sut: APIClient!

    override func setUpWithError() throws {
        sut = APIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

   

}
