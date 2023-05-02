//
//  SearchFavoriteCollectionViewCell.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 28.04.2023.
//

import UIKit

protocol SearchFavoriteCollectionViewCellProtocol: AnyObject {
    func notFav(indexPath: IndexPath)
}

class SearchFavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchFavoriteCollectionViewCell"
    
    let favCityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "City"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "background")
        imageView.alpha = 0.8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let notFavButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.slash.fill"), for: .normal)
        button.isSelected = false
        button.tintColor = .white
        button.backgroundColor = .clear
        
        return button
    }()
    
    var selectedIndexPath: IndexPath?
    
    weak var delegate: SearchFavoriteCollectionViewCellProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.layer.cornerRadius = 20
        
        contentView.addSubview(backImageView)
        contentView.addSubview(favCityLabel)
        contentView.addSubview(notFavButton)
        
        notFavButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            
            favCityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            
            notFavButton.topAnchor.constraint(equalTo: favCityLabel.bottomAnchor, constant: 8),
            notFavButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        
        self.delegate?.notFav(indexPath: selectedIndexPath!)
    }
    
    func config(cities: Geonames) {
    
        favCityLabel.text = "\(cities.name),\(cities.adminName1)"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
