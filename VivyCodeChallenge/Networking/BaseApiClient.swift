//
//  BaseApiClient.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 24.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//
import Foundation

class BaseApiClient {

    let session = URLSession.shared
    let url = URL(string: "https://restcountries.eu/rest/v2/all")!
    
    func allCountries(completionHandler: @escaping ([Country]) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                print("Something went wrong here")

                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let countries = try jsonDecoder.decode([Country].self, from: jsonData)
                DispatchQueue.main.async {
                    completionHandler(countries)
                }
            }  catch let error as NSError {
                print("Something went wrong here \(error.localizedDescription)")
            }
        }
            
        task.resume()
    }
}
