//
//  Analytic.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//
//
import Foundation

//Codable objects to handle service response

class Analytic: Codable {
    var manufacturer: String?
    var name: String?
    var code: String?
    var model: String?
    var statistics: UsageStatistics?

    enum CodingKeys: String, CodingKey {
        case manufacturer
        case name = "market_name"
        case code = "codename"
        case model = "model"
        case statistics = "usage_statistics"
    }
    
}

class UsageStatistics: Codable {
    var infos: [SessionInfo]?

    enum CodingKeys: String, CodingKey {
        case infos = "session_infos"
    }
}

class SessionInfo: Building {
    var purchases: [Item]?

    enum CodingKeys: String, CodingKey {
        case purchases = "purchases"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.purchases = try container.decode([Item].self, forKey: .purchases)
        try super.init(from: decoder)
    }
}

class Item: Codable {
    var id: Int?
    var categoryId: Int?
    var cost: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "item_id"
        case categoryId = "item_category_id"
        case cost
    }
}
