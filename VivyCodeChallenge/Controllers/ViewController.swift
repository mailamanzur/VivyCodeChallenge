//
//  ViewController.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 23.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let manager = CLLocationManager()
    var userLocation: CLLocation? {
        didSet {
            refreshList()
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var countries: [Country] = []
    var filteredCountries: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()

        let api = BaseApiClient.init()
        api.allCountries { [weak self] countries in
            self?.countries = countries
            self?.refreshList()
        }
    }
    
    private func refreshList() {
        filteredCountries = countries
            .filter { country in
                return country.match(with: searchBar.text)
            }
            .sorted(by: { country1, country2 in
                if let userLocation = userLocation {
                    return country1.distance(to: userLocation) < country2.distance(to: userLocation)
                }
                
                return country1.name < country2.name
            })
        
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        refreshList()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            userLocation = location
        } else {
            print("No location found")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as! CountryTableViewCell
        let country = filteredCountries[indexPath.row]
        let viewModel = CountryCellViewModel(country: country)
        cell.updateUI(viewModel: viewModel)
        return cell
    }
}
