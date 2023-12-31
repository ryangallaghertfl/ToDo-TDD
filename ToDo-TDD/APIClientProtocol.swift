//
//  APIClientProtocol.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation

protocol APIClientProtocol {
    func coordinate(for: String, completion: @escaping (Coordinate?) -> Void)
}
