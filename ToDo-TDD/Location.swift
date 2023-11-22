//
//  Location.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 17/11/2023.
//

import Foundation

struct Location {
    let name: String
    let coordinate: Coordinate?
    
    init(name: String, coordinate: Coordinate? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

//MARK: Location conforms to Equatable

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name &&
                      lhs.coordinate == rhs.coordinate
    }
}

//MARK: Location conforms to Codable

extension Location: Codable {
    
}
