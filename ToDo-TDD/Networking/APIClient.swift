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
    lazy var session: URLSessionProtocol = URLSession.shared
    
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
    
    func toDoItems() async throws -> [ToDoItem] {
        //define the URL, create a request, call data(for:delegate:) on the session property, and try to decode the result into an array of ToDoItems.
       guard let url =
               URL(string: "http://toodoo.app/items")
       else {
         return []
       }
       let request = URLRequest(url: url)
       let (data, _) = try await session.data(
         for: request,
            delegate: nil)
       let items = try JSONDecoder()
         .decode([ToDoItem].self, from: data)
       return items
     }

}

//MARK: Define GeoCoderProtocol so mock can be used
protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler)
}

//MARK: Extension to GLGeocoder allows us to use mocks in tests
extension CLGeocoder: GeoCoderProtocol {}

//MARK: define protocol to help mock URLSession for unit tests
protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

//MARK: URL session conforms to protocol for mock
extension URLSession: URLSessionProtocol {}
