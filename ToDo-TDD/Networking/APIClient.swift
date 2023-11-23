//
//  APIClient.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation
import CoreLocation

class APIClient: APIClientProtocol {
    func coordinate(for: String, completion: (Coordinate?) -> Void) {
    }
}

//MARK: Define GeoCoderProtocol so mock can be used
protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

//MARK: Extension to GLGeocoder allows us to use mocks in tests
extension CLGeocoder: GeoCoderProtocol {}
