//
//  WeatherHomeCollectionViewCell.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import UIKit
import SDWebImage

class WeatherHomeCollectionViewCell: UICollectionViewCell {
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
       }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "wind"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clockLabel: UILabel = {
        let label = UILabel()
        label.text = "wind"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.addSubview(backImageView)
        windStackView.addArrangedSubview(degreeLabel)
        windStackView.addArrangedSubview(windImageView)
        windStackView.addArrangedSubview(clockLabel)
        
        contentView.addSubview(windStackView)
        
        configConstraints()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
    }
    
    func configConstraints() {
        
        let windStackViewConstraints = [
            windStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            windStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            windStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            windStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(windStackViewConstraints)
    }
    
    func config(hourly: Hourly) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = Date(timeIntervalSince1970: TimeInterval(hourly.dt))
        let hour = dateFormatter.string(from: date)

        degreeLabel.text = String(format: "%0.0f°",hourly.temp)
        clockLabel.text = hour

//        let icon = hourly.weather[0].icon
//        windImageView.sd_setImage(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!)
        
        let switchIcon = hourly.weather[0].conditionName
        windImageView.image = UIImage(named: switchIcon)
    }
    
    func configHourlyBack(hourly: Hourly) {
        
        let date = Date()
        let apiDate = Date(timeIntervalSince1970: TimeInterval(hourly.dt))
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        let currentDate = dateFormatter.string(from: date)
        let hourlyDate = dateFormatter.string(from: apiDate)
        
        if currentDate == hourlyDate {
            backImageView.image = UIImage(named: "background")
        } else {
            backImageView.image = nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
