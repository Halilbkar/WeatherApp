//
//  SearchDataSource.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 20.04.2023.
//

import Foundation
import UIKit

protocol SearchDataSourceProtocol: AnyObject {
    func didTapSearchTable(citiesName: String, citiesLat: String, citiesLon: String)
    func reloadData()
    func setCity(city: String)
    func buttonHideConfig(searchText: String)
}

class SearchDataSource: NSObject {
    
    var favoriteCities = [Geonames]()
    var searchCities = [Geonames]()
    var selectedIndexPath: IndexPath?
    
    weak var delegate: SearchDataSourceProtocol?
}

extension SearchDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
                
        let citiesData = searchCities[indexPath.row]
        
        cell.config(model: citiesData)
        
        cell.delegate = self
        
        cell.selectedIndexPath = indexPath
        
        cell.favButton.isSelected = favoriteCities.contains(citiesData)
        cell.favButton.tintColor = favoriteCities.contains(citiesData) ? .red : .link
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                        
        let citiesData = searchCities[indexPath.row]
        
        print("\(citiesData.name)-\(citiesData.lat)-\(citiesData.lng)")
        
        self.delegate?.didTapSearchTable(citiesName: citiesData.name, citiesLat: citiesData.lat, citiesLon: citiesData.lng)
    }
}

extension SearchDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchFavoriteCollectionViewCell.identifier, for: indexPath) as! SearchFavoriteCollectionViewCell
        
        let citiesData = favoriteCities[indexPath.row]

        cell.config(cities: citiesData)
        
        cell.delegate = self
        
        cell.selectedIndexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let citiesData = favoriteCities[indexPath.row]
        
        print("\(citiesData.name)-\(citiesData.lat)-\(citiesData.lng)")
        
        self.delegate?.didTapSearchTable(citiesName: citiesData.name, citiesLat: citiesData.lat, citiesLon: citiesData.lng)
    }
}

extension SearchDataSource: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        self.delegate?.buttonHideConfig(searchText: searchText)
        
        if searchText.isEmpty {
            searchCities.removeAll()
            self.delegate?.reloadData()
        } else {
            let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.delegate?.setCity(city: encodedSearchText!)
        }
    }
}

extension SearchDataSource: SearchTableViewCellProtocol {
    
    func favIndex(indexPath: IndexPath) {
        let favCities = searchCities[indexPath.row]
                    
        favoriteCities.append(favCities)
        
        UserDefaultsManager.shared.userDefaultsAdd(cities: favoriteCities)
        
        self.delegate?.reloadData()
    }
    
    func notFavIndex(indexPath: IndexPath) {
                
        let favCities = searchCities[indexPath.row]
        
        UserDefaultsManager.shared.userDefaultsRemove(cities: &favoriteCities, favCities: favCities)
        
        self.delegate?.reloadData()
    }
}

extension SearchDataSource: SearchFavoriteCollectionViewCellProtocol {
    func notFav(indexPath: IndexPath) {
        
        let favCities = favoriteCities[indexPath.row]
        
        UserDefaultsManager.shared.userDefaultsRemove(cities: &favoriteCities, favCities: favCities)
        
        self.delegate?.reloadData()
    }
}
