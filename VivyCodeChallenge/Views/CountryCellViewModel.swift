//
//  CountryCellViewModel.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import Foundation

struct CountryCellViewModel {
    let imageFlagUrl: URL?
    let countryName: String
    let population: String
    let area: String
}

extension CountryCellViewModel {
    init(country: Country) {
        if let flagUrlString = country.flag {
            self.imageFlagUrl = URL(string: flagUrlString)
        } else {
            self.imageFlagUrl = nil
        }
        
        self.countryName = country.name
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        self.population = numberFormatter.string(from: NSNumber(value: country.population)) ?? ""
        
        if let area = country.area {
            self.area = numberFormatter.string(from: NSNumber(value: area)) ?? ""
        } else {
            self.area = ""
        }
    }
}
