//
//  CitiesModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 20.04.2023.
//

import Foundation

struct CitiesModel: Codable {
    
    let geonames: [Geonames]
}

struct Geonames: Codable, Equatable {
    
    static func ==(lhs: Geonames, rhs: Geonames) -> Bool {
        return lhs.lat == rhs.lat &&
        lhs.lng == rhs.lng &&
        lhs.name == rhs.name &&
        lhs.countryName == rhs.countryName &&
        lhs.adminName1 == rhs.adminName1
    }
    
    let lat: String
    let lng: String
    let name: String
    let countryName: String
    let adminName1: String
}
