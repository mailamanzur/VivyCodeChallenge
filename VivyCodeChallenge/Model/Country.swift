//
//  Country.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import Foundation
import CoreLocation

struct Country: Decodable {
    let name: String
    let capital: String
    let region: String
    let languages: [Language]
    let currencies: [Currency]
    let population: Int
    let area: Double?
    let flag: String?
    let coordinate: CLLocationCoordinate2D?
}

extension Country {
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case region
        case languages
        case currencies
        case population
        case area
        case flag
        case coordinate = "latlng"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.capital = try container.decode(String.self, forKey: .capital)
        self.region = try container.decode(String.self, forKey: .region)
        self.languages = try container.decode([Language].self, forKey: .languages)
        let currencies = try container.decodeIfPresent([Currency].self, forKey: .currencies) ?? []
        self.currencies = currencies.filter { $0.name != nil }
        self.population = try container.decode(Int.self, forKey: .population)
        self.area = try container.decodeIfPresent(Double.self, forKey: .area)
        self.flag = try container.decodeIfPresent(String.self, forKey: .flag)
        let latlng = try container.decodeIfPresent([Double].self, forKey: .coordinate) ?? []
        
        if latlng.count == 2 {
            self.coordinate = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
        } else {
            self.coordinate = nil
        }
    }
}

extension Country {
    func match(with searchQuery: String?) -> Bool {
        guard let searchQuery = searchQuery?.lowercased(),
            !searchQuery.isEmpty else { return true }
        
        return name.lowercased().contains(searchQuery)  ||
            capital.lowercased().contains(searchQuery) ||
            region.lowercased().contains(searchQuery) ||
            languages.first(where: { language in language.match(with: searchQuery) }) != nil ||
            currencies.first(where: { currency in currency.match(with: searchQuery) }) != nil

    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        guard let coordinate = coordinate else { return .greatestFiniteMagnitude }
        let countryLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return location.distance(from: countryLocation)
    }
}

