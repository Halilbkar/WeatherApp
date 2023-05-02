//
//  WeatherManager.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import Foundation

struct Constants {
    static let API_KEY = "1718f152e7b380f8deff44940461a62e"
    static let baseURL = "https://api.openweathermap.org/data/3.0/onecall?units=metric&exclude="
    static let dailyURL = "\(Constants.baseURL)minutely,alerts,hourly,current&lang=en&appid="
    static let hourlyURL = "\(Constants.baseURL)minutely,alerts,daily,current&appid="
    static let currentURL = "\(Constants.baseURL)minutely,alerts,daily,hourly&appid="    
}

enum APIError: Error {
    case failedtoGetData
}

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func getCurrentData(lat: String, lon: String, completion: @escaping (Result<Current, Error>) -> Void) {

        guard let url = URL(string: "\(Constants.currentURL)\(Constants.API_KEY)&lat=\(lat)&lon=\(lon)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                completion(.failure(APIError.failedtoGetData))
                return
            }

            do {
                let results = try JSONDecoder().decode(CurrentModel.self, from: data)
                completion(.success(results.current))
            } catch {
                print(error)
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }

    func getDailyData(lat: String, lon: String, completion: @escaping (Result<[Daily], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.dailyURL)\(Constants.API_KEY)&lat=\(lat)&lon=\(lon)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                completion(.failure(APIError.failedtoGetData))
                return
            }

            do {
                let results = try JSONDecoder().decode(DailyModel.self, from: data)
                completion(.success(results.daily))
            } catch {
                print(error)
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getHourlyData(lat: String, lon: String, completion: @escaping (Result<[Hourly], Error>) -> ()) {
        
        guard let url = URL(string: "\(Constants.hourlyURL)\(Constants.API_KEY)&lat=\(lat)&lon=\(lon)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                completion(.failure(APIError.failedtoGetData))
                return
            }

            do {
                let results = try JSONDecoder().decode(HourlyModel.self, from: data)
                completion(.success(results.hourly))
            } catch {
                print(error)
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getCitiesData(city: String, completion: @escaping (Result<[Geonames], Error>) -> ()) {
        
        guard let url = URL(string: "http://api.geonames.org/searchJSON?q=\(city)&countryBias=TR&username=halilbkar") else { return }
    
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                completion(.failure(APIError.failedtoGetData))
                return
            }

            do {
                let results = try JSONDecoder().decode(CitiesModel.self, from: data)
                completion(.success(results.geonames))
            } catch {
                print(error)
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
}

