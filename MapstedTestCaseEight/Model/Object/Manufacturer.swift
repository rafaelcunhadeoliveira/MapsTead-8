//
//  Manufacturer.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-12.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

/*
 Objects used to help display information
 */

class Product {
    var id: Int
    var categoryId: Int
    var cost: Double
    var quantity = 0
    var manufacturerName: String

    init(id: Int, categoryId: Int, cost: Double, manufacturerName: String) {
        self.id = id
        self.cost = cost
        self.categoryId = categoryId
        self.manufacturerName = manufacturerName
    }
}

// Used inheritance to help retrieve information efficiently

class CountryValue {
    var countryName: String
    init(_ name: String) {
        self.countryName = name
    }
}

class StateValue: CountryValue {
    var stateName: String

    init(stateName: String,
         countryName: String) {
        self.stateName = stateName
        super.init(countryName)
    }
}

class BuildingValue: StateValue {
    var id: Int
    var value: Double = 0.0

    init(id: Int, stateName: String, countryName: String) {
        self.id = id
        super.init(stateName: stateName, countryName: countryName)
    }
}
