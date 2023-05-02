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
    
    let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 50, left: 20, bottom: 220, right: 20)
        layout.minimumLineSpacing = 35
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherHeroCollectionViewCell.self, forCellWithReuseIdentifier: WeatherHeroCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var daily = [Daily]()
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
}

extension WeatherHomeHeroUIView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daily.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHeroCollectionViewCell.identifier, for: indexPath) as! WeatherHeroCollectionViewCell

        let daily = daily[indexPath.row]

        cell.config(daily: daily)
        
        self.delegate?.configProperty(daily: daily)

        return cell
    }
}
