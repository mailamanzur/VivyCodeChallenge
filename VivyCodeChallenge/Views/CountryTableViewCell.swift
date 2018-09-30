//
//  CountryTableViewCell.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import UIKit
import WebKit

class CountryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CountryTableViewCell"

    @IBOutlet weak var imageFlag: WKWebView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    func updateUI(viewModel: CountryCellViewModel) {
        if let url = viewModel.imageFlagUrl {
            let request = URLRequest(url: url)
            imageFlag.load(request)
        }
        countryLabel.text = viewModel.countryName
        populationLabel.text = viewModel.population
        areaLabel.text = viewModel.area
    }
    
}

// MARK: Accessibility
extension CountryTableViewCell {
    func applyAccessibility(_ country: Country) {
        countryLabel.isAccessibilityElement = true
        countryLabel.accessibilityTraits = UIAccessibilityTraitNone
        countryLabel.accessibilityLabel = "Country"
        
        populationLabel.isAccessibilityElement = true
        populationLabel.accessibilityTraits = UIAccessibilityTraitNone
        populationLabel.accessibilityLabel = "Population"
        
        areaLabel.isAccessibilityElement = true
        areaLabel.accessibilityTraits = UIAccessibilityTraitNone
        areaLabel.accessibilityLabel = "Area"
        
        countryLabel.font = UIFont.preferredFont(forTextStyle: .body)
        countryLabel.adjustsFontForContentSizeCategory = true
        
        populationLabel.font = UIFont.preferredFont(forTextStyle: .body)
        populationLabel.adjustsFontForContentSizeCategory = true
        
        areaLabel.font = UIFont.preferredFont(forTextStyle: .body)
        areaLabel.adjustsFontForContentSizeCategory = true
        
    }
}
