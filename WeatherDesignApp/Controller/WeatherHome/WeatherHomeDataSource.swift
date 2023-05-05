//
//  WeatherHomeDataSource.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import Foundation
import UIKit

protocol WeatherHomeDataSourceProtocol: AnyObject {
    func navigationPush()
}

class WeatherHomeDataSource: NSObject {
    
    weak var delegate: WeatherHomeDataSourceProtocol?
    
    var current: Current?
    var hourly = [Hourly]()
    var selectedIndexPath: IndexPath?
}

extension WeatherHomeDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHomeCollectionViewCell.identifier, for: indexPath) as! WeatherHomeCollectionViewCell
        
        let hourlyData = hourly[indexPath.row]
        
        cell.config(hourly: hourlyData)
        cell.configHourlyBack(hourly: hourlyData)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.navigationPush()
    }
}



