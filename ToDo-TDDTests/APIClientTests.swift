//
//  APIClientTests.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//
import XCTest
//Intents and Contacts useful for creating CLPlacemark instances in tests
import Intents
import Contacts
@testable import ToDo_TDD

final class APIClientTests: XCTestCase {
    
    var sut: APIClient!

    override func setUpWithError() throws {
        sut = APIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_APIClient_coordinate_fetchesCoordinate() {
      let geoCoderMock = GeoCoderProtocolMock()
      sut.geoCoder = geoCoderMock
      let location = CLLocation(latitude: 1,
                                longitude: 2)
      let placemark = CLPlacemark(location: location,
                                  name: nil,
                                  postalAddress: nil)
//The GeoCoderProtocolMock class captures the completion handler of the geocodeAddressString(_:complectionHandler:) call.
      var result: Coordinate?
      sut.coordinate(for: "") { coordinate in
        result = coordinate
      }
      geoCoderMock.completionHandler?([placemark], nil)
//heck whether the method was called with the address string we provided and whether the coordinate was passed into the completion closure of the coordinate(for:completion:) method.
      XCTAssertEqual(result?.latitude,
                     location.coordinate.latitude)
      XCTAssertEqual(result?.longitude,
                     location.coordinate.longitude)
    }
    
    func test_APIClient_coordinate_shouldCallGeoCoderWithAddress() {
       let geoCoderMock = GeoCoderProtocolMock()
       sut.geoCoder = geoCoderMock
       let expectedAddress = "dummy address"

       sut.coordinate(for: expectedAddress) { _ in
       }

       XCTAssertEqual(geoCoderMock.geocodeAddressString,
                      expectedAddress)
     }


   

}
