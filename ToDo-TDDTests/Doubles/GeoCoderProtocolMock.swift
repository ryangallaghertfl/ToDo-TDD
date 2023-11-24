//
//  GeoCoderProtocolMock.swift
//  ToDo-TDDTests
//
//  Created by Ryan Gallagher on 23/11/2023.
//

import Foundation
@testable import ToDo_TDD
import CoreLocation

class GeoCoderProtocolMock: GeoCoderProtocol {
    var geocodeAddressString: String?
    var completionHandler: CLGeocodeCompletionHandler?
    func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
        geocodeAddressString = addressString
        self.completionHandler = completionHandler
    }
}

