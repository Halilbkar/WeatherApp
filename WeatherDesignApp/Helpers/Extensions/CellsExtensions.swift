//
//  CellsExtensions.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 4.05.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
