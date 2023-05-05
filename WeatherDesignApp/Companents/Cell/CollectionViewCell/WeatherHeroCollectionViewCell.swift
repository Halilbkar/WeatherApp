//
//  WeatherHeroCollectionViewCell.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import UIKit
import SDWebImage
import Lottie

class WeatherHeroCollectionViewCell: UICollectionViewCell {
        
    private var animationView: LottieAnimationView?
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "background")
        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        return imageView
    }()
    
    private lazy var cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cloud")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.text = "days"
        label.layer.cornerRadius = 12
        label.layer.backgroundColor = CGColor(red: 20, green: 20, blue: 20, alpha: 1)
        label.layer.borderWidth = 1
        label.font = .boldSystemFont(ofSize: 15)
        label.layer.borderColor = CGColor(gray: 10, alpha: 1)
        label.tintColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 90)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "wind"
        label.textColor = .white
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.layer.cornerRadius = 80
        
        animationView = .init(name: "sky")
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(animationView!)
        contentView.addSubview(daysLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(degreeLabel)
        contentView.addSubview(cloudImageView)
        
        animationView!.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImageView.frame = self.bounds
        
        animationViewConfig()
        
        NSLayoutConstraint.activate([
            
            daysLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            daysLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            daysLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            
            conditionLabel.topAnchor.constraint(equalTo: daysLabel.bottomAnchor, constant: 20),
            conditionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conditionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            
            degreeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            degreeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            degreeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            
            cloudImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cloudImageView.heightAnchor.constraint(equalToConstant: 64),
            cloudImageView.widthAnchor.constraint(equalToConstant: 64),
            cloudImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
        
    }
    
    func config(daily: Daily) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(daily.dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE d MMM"
        
        let formatDate = dateFormatter.string(from: date)
        
        degreeLabel.text = String(format: "%0.0f°", daily.temp.day)
        daysLabel.text = formatDate
        
        let switchIcon = daily.weather[0].conditionName
        cloudImageView.image = UIImage(named: switchIcon)
        
        conditionLabel.text = "\(daily.weather[0].main) / \(daily.weather[0].description.capitalized)"
        
    }
    
    private func animationViewConfig() {
        
        animationView!.frame = contentView.bounds
        animationView!.contentMode = .scaleAspectFill
        animationView!.loopMode = .loop
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
