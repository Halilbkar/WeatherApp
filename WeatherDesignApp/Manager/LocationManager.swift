//
//  LocationManager.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 19.04.2023.
//

import Foundation
import CoreLocation
import UIKit


class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
}

extension LocationManager {
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func getCityLocation(city: String) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            
            guard error == nil, let placemark = placemarks?.first else { return }
            guard let location = placemark.location else { return }
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        }
    }
    
    func getCityName(nav: UINavigationItem) {
        
        guard let location = locationManager.location else { return }

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first?.locality, error == nil else { return }
            globalName = placemark
            nav.title = placemark
            
        }
    }
    
    func getCitiesCityName(nav: UINavigationItem) {
        
        guard let latitude = Double(globalLat!), let longitude = Double(globalLon!) else { return }
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let citiesLocation = CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: kCLLocationAccuracyBest, verticalAccuracy: kCLLocationAccuracyBest, timestamp: Date())
        
        CLGeocoder().reverseGeocodeLocation(citiesLocation) { placemarks, error in
            guard let placemark = placemarks?.first?.locality, error == nil else { return }
            nav.title = placemark
        }
    }
    
    func getCityNameAndLocation(city: String) {
                
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            
            guard error == nil, let placemark = placemarks?.first else { return }
            guard let location = placemark.location else { return }
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
            
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first?.locality, error == nil else { return }
               print(placemark)
            }
        }
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locations = locations.last else { return }
        
        globalLat = String(locations.coordinate.latitude)
        globalLon = String(locations.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
