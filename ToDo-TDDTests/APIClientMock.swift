//
//  APIClientMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation

@testable import ToDo_TDD

class APIClientMock: APIClientProtocol {
    var coordinateAddress: String?
    var coordinateReturnValue: Coordinate?

    func coordinate(for address: String,completion: (Coordinate?) -> Void) {
        coordinateAddress = address
        completion(coordinateReturnValue)
    }
}
