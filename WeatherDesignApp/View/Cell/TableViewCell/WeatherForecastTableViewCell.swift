//
//  WeatherForecastTableViewCell.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 15.04.2023.
//

import UIKit
import SDWebImage

class WeatherForecastTableViewCell: UITableViewCell {

    static let identifier = "WeatherForecastTableViewCell"
    
    private let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomorrow"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "23 / 24"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherMainLabel: UILabel = {
        let label = UILabel()
        label.text = "Rain / Cloudy"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(daysLabel)
        contentView.addSubview(cloudImageView)
        contentView.addSubview(degreeLabel)
        contentView.addSubview(weatherMainLabel)
        
        configConstraints()
        
        self.backgroundColor = .clear
        selectionStyle = .none
    }
    
    func config(daily: Daily) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E"
        
        let degreeMin = String(format: "%0.0f°", daily.temp.min)
        let degreeMax = String(format: "%0.0f°", daily.temp.max)
        degreeLabel.text = "\(degreeMin) / \(degreeMax)"
        
        weatherMainLabel.text = daily.weather[0].main
        
        let date = Date(timeIntervalSince1970: TimeInterval(daily.dt))
        let nextDays = Calendar.current.date(byAdding: .day, value: 2, to: date)!

        let formatDate = dateFormatter.string(from: nextDays)
        
        daysLabel.text = formatDate
 
        let switchIcon = daily.weather[0].conditionName
        cloudImageView.image = UIImage(named: switchIcon)
        
    }
    
    func configConstraints() {
        
        let daysLabelConstraints = [
            daysLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            daysLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ]
        
        let cloudImageViewConstraints = [
            cloudImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            cloudImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 150),
        ]
        
        let weatherMainLabelConstraints = [
            weatherMainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherMainLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 10)
        ]
        
        let degreeLabelConstraints = [
            degreeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            degreeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(cloudImageViewConstraints)
        NSLayoutConstraint.activate(daysLabelConstraints)
        NSLayoutConstraint.activate(degreeLabelConstraints)
        NSLayoutConstraint.activate(weatherMainLabelConstraints)

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
