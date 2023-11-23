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
    
    func coordinate(
        for address: String,
        completion: @escaping (Coordinate?) -> Void) {
          geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let clCoordinate = placemarks?.first?.location?.coordinate
            else {
              completion(nil)
              return
            }
            let coordinate = Coordinate(
              latitude: clCoordinate.latitude,
              longitude: clCoordinate.longitude)
            completion(coordinate)
          }
        }

}

//MARK: Define GeoCoderProtocol so mock can be used
protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

//MARK: Extension to GLGeocoder allows us to use mocks in tests
extension CLGeocoder: GeoCoderProtocol {}
