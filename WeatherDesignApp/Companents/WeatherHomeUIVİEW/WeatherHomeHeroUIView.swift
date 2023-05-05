//
//  WeatherHeroUIView.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import UIKit

protocol WeatherHomeHeroUIViewProtocol: AnyObject {
    func configProperty(daily: Daily)
}

class WeatherHomeHeroUIView: UIView {
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 35
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherHeroCollectionViewCell.self, forCellWithReuseIdentifier: WeatherHeroCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var dailyArray = [Daily]()
    weak var delegate: WeatherHomeHeroUIViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(weatherCollectionView)
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        weatherCollectionView.frame = bounds
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    public func collectionViewReloadData() {
        self.weatherCollectionView.reloadData()
    }
}

extension WeatherHomeHeroUIView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHeroCollectionViewCell.identifier, for: indexPath) as! WeatherHeroCollectionViewCell

        let daily = dailyArray[indexPath.row]

        cell.config(daily: daily)
                
        self.delegate?.configProperty(daily: daily)

        return cell
    }
}
