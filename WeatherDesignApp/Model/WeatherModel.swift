//
//  WeatherOneCallModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 12.04.2023.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    var conditionName: String {
          switch id {
          case 200...232:
              return "thunderstorm"
          case 300...321:
              return "showerRain"
          case 500...531:
              return "rain"
          case 600...622:
              return "snow"
          case 701...781:
              return "mist"
          case 800:
              return "clearSky"
          case 801...804:
              return "scarletClouds"
          default:
              return icon
          }
      }
}





