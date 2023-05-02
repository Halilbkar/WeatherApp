//
//  DailyModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 12.04.2023.
//

import Foundation

struct DailyModel: Codable {
    let daily: [Daily]
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let humidity: Int
    let wind_speed: Double
    let clouds: Int
    let weather: [Weather]
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
}


