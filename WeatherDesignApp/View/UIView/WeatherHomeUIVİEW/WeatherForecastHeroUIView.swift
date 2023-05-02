//
//  WeatherForecastHeroUIView.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 15.04.2023.
//

import UIKit

class WeatherForecastHeroUIView: UIView {

    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomorrow"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "23/24"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherMainLabel: UILabel = {
        let label = UILabel()
        label.text = "Rain - Cloudy"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backImageView)
        addSubview(cloudImageView)
        addSubview(daysLabel)
        addSubview(degreeLabel)
        addSubview(weatherMainLabel)
        
        configConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
    }
    
    func configConstraints() {
        
        let cloudImageViewConstraints = [
            cloudImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            cloudImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cloudImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            cloudImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -230)
        ]
        
        let daysLabelConstraints = [
            daysLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            daysLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 30)
        ]
        
        let degreeLabelConstraints = [
            degreeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            degreeLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 30)
        ]
        
        let weatherMainLabelConstraints = [
            weatherMainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            weatherMainLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 30)
        ]
        
        NSLayoutConstraint.activate(cloudImageViewConstraints)
        NSLayoutConstraint.activate(daysLabelConstraints)
        NSLayoutConstraint.activate(degreeLabelConstraints)
        NSLayoutConstraint.activate(weatherMainLabelConstraints)

    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

extension WeatherForecastHeroUIView {
    func tomorrowDaysHero(daily: Daily) {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E,d"

        let degreeMin = String(format: "%0.0f°", daily.temp.min)
        let degreeMax = String(format: "%0.0f°", daily.temp.max)
        degreeLabel.text = "\(degreeMin)/\(degreeMax)"

        weatherMainLabel.text = "\(daily.weather[0].main) - \(daily.weather[0].description)"

//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: daily.dt)!
//        let days = dateFormatter.string(from: tomorrow)
//        daysLabel.text = days
        
        let date = Date(timeIntervalSince1970: TimeInterval(daily.dt))
        let formatDate = dateFormatter.string(from: date)

//        let days = dateFormatter.string(from: daily.dt)
        daysLabel.text = formatDate

//        let icon = daily.weather[0].icon
//        cloudImageView.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!)
        
        let switchIcon = daily.weather[0].conditionName
        cloudImageView.image = UIImage(named: switchIcon)

        self.reloadInputViews()
    }
}
