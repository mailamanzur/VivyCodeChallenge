//
//  Currency.swift
//  VivyCodeChallenge
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let name: String?
    let symbol: String?
}

extension Currency {

    func match(with searchQuery: String) -> Bool {
        return (name?.lowercased() ?? "").contains(searchQuery) ||
               (symbol ?? "").contains(searchQuery)
    }
}
