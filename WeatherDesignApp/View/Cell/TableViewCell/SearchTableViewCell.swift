//
//  SearchTableViewCell.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 20.04.2023.
//

import UIKit

protocol SearchTableViewCellProtocol: AnyObject {
    func favIndex(indexPath: IndexPath)
    func notFavIndex(indexPath: IndexPath)
}

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let daysLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomorrow"
        label.textColor = .systemGray2
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "mappin")
        return imageView
    }()
    
    let favButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.isSelected = false
        
        return button
        
    }()
    
    weak var delegate: SearchTableViewCellProtocol?
    
    var selectedIndexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(locationImageView)
        contentView.addSubview(daysLabel)
        contentView.addSubview(favButton)
        
        favButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            locationImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            favButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            daysLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            daysLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 10)            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favButton.tintColor = favButton.isSelected ? .red : .link
    }
    
    @objc private func buttonTapped() {
        
        favButton.isSelected = !favButton.isSelected
        
        favButton.tintColor = favButton.isSelected ? .red : .link
        
        if favButton.isSelected {
            self.delegate?.favIndex(indexPath: selectedIndexPath!)
        } else {
            self.delegate?.notFavIndex(indexPath: selectedIndexPath!)
        }
    }
    
    func config(model: Geonames) {
        
        daysLabel.text = "\(model.name),\(model.adminName1),\(model.countryName)"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
