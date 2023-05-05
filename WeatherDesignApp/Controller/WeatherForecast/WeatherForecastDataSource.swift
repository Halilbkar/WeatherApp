//
//  WeatherForecastDataSource.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 16.04.2023.
//

import Foundation
import UIKit

class WeatherForecastDataSource: NSObject {
    
    var daily = [Daily]()
    
    var heroView = WeatherForecastHeroUIView()
    var propertyView = WeatherPropertyUIView()

}

extension WeatherForecastDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.identifier, for: indexPath) as! WeatherForecastTableViewCell
        
        let dailyData = daily[indexPath.row]
        
        cell.config(daily: dailyData)
        
        heroView.tomorrowDaysHero(daily: daily[1])
        propertyView.tomorrowDaysPropery(daily: daily[1])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
