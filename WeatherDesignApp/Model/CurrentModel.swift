//
//  CurrentModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 12.04.2023.
//

import Foundation

struct CurrentModel: Codable {
    let current: Current
}

struct Current: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [Weather]
}
