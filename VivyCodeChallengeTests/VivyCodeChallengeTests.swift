//
//  VivyCodeChallengeTests.swift
//  VivyCodeChallengeTests
//
//  Created by maila manzur on 25.09.18.
//  Copyright © 2018 maila manzur. All rights reserved.
//

import XCTest
@testable import VivyCodeChallenge

class VivyCodeChallengeTests: XCTestCase {
    
    func testDecodeCountryList() {
        let bundle = Bundle(for: VivyCodeChallengeTests.self)
        let jsonPath = bundle.path(forResource: "CountryList", ofType: "json")!
        let jsonData = FileManager().contents(atPath: jsonPath)!
        let jsonDecoder = JSONDecoder()

        let sut = try! jsonDecoder.decode([Country].self, from: jsonData)
        XCTAssertEqual(sut.count, 250)
        XCTAssertEqual(sut.first?.name, "Afghanistan")
        XCTAssertEqual(sut.first?.capital,"Kabul")
        XCTAssertEqual(sut.first?.population, 27657145)
    }
}
