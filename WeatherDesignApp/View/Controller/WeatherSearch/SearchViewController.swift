//
//  SearchViewController.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 20.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let favoriteCityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 100)
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: SearchFavoriteCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "bottomColor")

        return collectionView
    }()
    
    private let searchTableView: UITableView = {
        
        let table = UITableView()
        table.backgroundColor = UIColor(named: "bottomColor")
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        return table
    }()
    
    private let backImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .black
        searchBar.backgroundImage = UIImage()
        let ovalImage = UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        searchBar.backgroundImage = ovalImage?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        searchBar.tintColor = .clear
        searchBar.searchTextField.textColor = UIColor.white
        
        return searchBar
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .white

        return button
        
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.backgroundColor = .white

        
        return button
    }()
    
    let heroLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Pick Location"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Find the city that you want to know the detailed weather info at this time."
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        view.addSubview(heroLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(favoriteCityCollectionView)
        view.addSubview(searchTableView)
        view.addSubview(searchBar)
        view.addSubview(locationButton)
        view.addSubview(favoriteButton)
                
        searchTableView.delegate = viewModel.dataSource
        searchTableView.dataSource = viewModel.dataSource
        
        favoriteCityCollectionView.delegate = viewModel.dataSource
        favoriteCityCollectionView.dataSource = viewModel.dataSource
        
        viewModel.dataSource.delegate = self
        viewModel.delegate = self
        
        searchBar.delegate = viewModel.dataSource
        
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        searchTableView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchUserDefaults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        NSLayoutConstraint.activate([
            
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImageView.heightAnchor.constraint(equalToConstant: 260),
            
            heroLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            heroLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: heroLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            searchBar.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: locationButton.leadingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteCityCollectionView.topAnchor.constraint(equalTo: backImageView.bottomAnchor),
            favoriteCityCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCityCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCityCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchTableView.topAnchor.constraint(equalTo: backImageView.bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            
            favoriteButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func locationButtonTapped() {
        
        viewModel.fetchLocationSetup()
        LocationManager.shared.getCityName(nav: WeatherHomeViewController().navigationItem)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func favoriteButtonTapped() {
        
        searchBar.text = ""
        searchTableView.isHidden = true
    }
}

extension SearchViewController: SearchDataSourceProtocol {
    
    func didTapSearchTable(citiesName: String, citiesLat: String, citiesLon: String) {
       
        globalLat = citiesLat
        globalLon = citiesLon
        globalName = citiesName
        
        navigationController?.popToRootViewController(animated: true)
    }

    func setCity(city: String) {
        DispatchQueue.main.async {
            self.viewModel.fetchCitiesData(city: city)
            self.searchTableView.reloadData()
        }
    }
    
    func buttonHideConfig(searchText: String) {
//        locationButton.isHidden = !searchText.isEmpty
        searchTableView.isHidden = searchText.isEmpty
    }
    
    func reloadData() {
        self.searchTableView.reloadData()
        self.favoriteCityCollectionView.reloadData()
    }
}

extension SearchViewController: SearchViewModelProtocol {
    
    func reloadTable() {
        self.searchTableView.reloadData()
        self.favoriteCityCollectionView.reloadData()
    }
}
