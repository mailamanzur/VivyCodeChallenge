//
//  Language.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import Foundation

struct Language: Decodable {
    let name: String
}

extension Language {
    
    func match(with searchQuery: String) -> Bool {
        return name.lowercased().contains(searchQuery)
    }

}
