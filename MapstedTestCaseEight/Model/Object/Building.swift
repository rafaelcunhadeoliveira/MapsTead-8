//
//  Building.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

//Codable objects using inheritance to help retrieve info

class Building: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "building_id"
        case name = "building_name"
    }
}

class BuildingInfo: Building {
    
    var city: String?
    var state: String?
    var country: String?

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case state = "state"
        case country = "country"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        try super.init(from: decoder)
    }
}
