//
//  HourlyModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 12.04.2023.
//

import Foundation

struct HourlyModel: Codable {
    let hourly: [Hourly]
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}
