//
//  APIClient.swift
//  ToDo-TDD
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation
import CoreLocation

class APIClient: APIClientProtocol {
    //lazy keyword means that the initialiser is called the first time the property is accessed, so it has no value until it is accessed
    lazy var geoCoder: GeoCoderProtocol = CLGeocoder()
    
    func coordinate(for: String, completion: (Coordinate?) -> Void) {
       
            }
}

//MARK: Define GeoCoderProtocol so mock can be used
protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

//MARK: Extension to GLGeocoder allows us to use mocks in tests
extension CLGeocoder: GeoCoderProtocol {}
