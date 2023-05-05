//
//  WeatherPropertyUIView.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import UIKit

class WeatherPropertyUIView: UIView {
    
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let humidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let visibilityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "wind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "humidity")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let visibilityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "eye.slash")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visibilityLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let windLabel2: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityLabel2: UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visibilityLabel2: UILabel = {
        let label = UILabel()
        label.text = "Visibility"
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(windStackView)
        addSubview(humidityStackView)
        addSubview(visibilityStackView)
        
        windStackView.addArrangedSubview(windImageView)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windLabel2)
        
        humidityStackView.addArrangedSubview(humidityImageView)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityLabel2)
        
        visibilityStackView.addArrangedSubview(visibilityImageView)
        visibilityStackView.addArrangedSubview(visibilityLabel)
        visibilityStackView.addArrangedSubview(visibilityLabel2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            windStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            windStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15),
            windStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            humidityStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            humidityStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15),
            humidityStackView.leadingAnchor.constraint(equalTo: windStackView.trailingAnchor, constant: 85),
            
            visibilityStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            visibilityStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15),
            visibilityStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
            
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func configProperty(daily: Daily) {
        
        visibilityLabel.text = String(daily.clouds)
        humidityLabel.text = String(daily.humidity)
        windLabel.text = String(daily.wind_speed)
    
        self.reloadInputViews()
    }
}

extension WeatherPropertyUIView {
    
    func tomorrowDaysPropery(daily: Daily) {

        visibilityLabel.text = String(daily.clouds)
        humidityLabel.text = String(daily.humidity)
        windLabel.text = String(daily.wind_speed)

        self.reloadInputViews()
    }
}
