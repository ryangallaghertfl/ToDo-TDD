//
//  URLSessionProtocolMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation
@testable import ToDo_TDD

//allows us to define the return value of data(for:delegate:) for unit testing purposes

class URLSessionProtocolMock: URLSessionProtocol {

  var dataForDelegateReturnValue: (Data, URLResponse)?
  var dataForDelegateRequest: URLRequest?
  var dataForDelegateError: Error?

  func data(for request: URLRequest,
            delegate: URLSessionTaskDelegate?)
  async throws -> (Data, URLResponse) {

    if let error = dataForDelegateError {
      throw error
    }

    dataForDelegateRequest = request

    guard let dataForDelegateReturnValue =
            dataForDelegateReturnValue else {
              fatalError()
            }
    return dataForDelegateReturnValue
  }
}
