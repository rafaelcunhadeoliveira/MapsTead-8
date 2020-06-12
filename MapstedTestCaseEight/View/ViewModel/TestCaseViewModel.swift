//
//  TestCaseViewModel.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

class TestCaseViewModel {

    // MARK: - Variables
    
    lazy var service = ServiceRequest()
    var buildings: [BuildingInfo] = []
    var buildingsValue: [BuildingValue] = []
    var products: [Product] = []
    var countries: [String] = []
    var statesName: [String] = []
    var productsCategoriesNames: [String] = []
    var manufacturers: [String] = []
    var productsIdNames: [String] = []

    //MARK: - Service Request

    func getBuildingData(success: @escaping() -> Void,
                             failure: @escaping(Error) -> Void) {
        service.getBuildingData(success: { (response) in
            self.buildings = response
            self.transformBuildingsData()
            success()
        }) { (error) in
            failure(error)
        }
    }

    func getAnalyticsData(success: @escaping() -> Void,
                          failure: @escaping(Error) -> Void) {
        service.getAnalyticsData(success: { (response) in
            self.transformAnalyticsData(response)
            success()
        }) { (error) in
            failure(error)
        }
    }

    //MARK: - Data

    private func transformAnalyticsData(_ analytics: [Analytic]) {
        for analytic in analytics {
            guard let name = analytic.manufacturer else { break }
            addManifacture(name)
            getPrice(infos: analytic.statistics?.infos ?? [], name)
        }
    }
    
    private func getPrice(infos: [SessionInfo],_ man: String) {
        var total = 0.0
        for info in infos {
            guard let id = info.id else { break }
            let countryState = getStateByBuildingId(id)
            let building = BuildingValue(id: id, stateName: countryState.first ?? "", countryName: countryState.last ?? "")
            for item in info.purchases ?? [] {
                let prod = Product(id: item.id ?? -1,
                                           categoryId: item.categoryId ?? -1,
                                           cost: item.cost ?? 0,
                                           manufacturerName: man)
                addProduct(prod)
                total += prod.cost
                products.append(prod)
            }
            building.value = total
            buildingsValue.appendUnique(building)
        }
    }

    private func transformBuildingsData() {
        for building in buildings {
            guard let state = building.state,
                let country = building.country else { break }
            addState(state)
            addContry(country)
        }
    }

    func getStateByBuildingId(_ id: Int) -> [String] {
        guard let building = buildings.filter({$0.id == id}).first else { return [] }
        let stateName = building.state ?? ""
        let countryName = building.country ?? ""
        return [stateName, countryName]
    }
    
    //MARK: - Validations
    //Add unique values for the picker view

    private func addManifacture(_ name: String) {
        if !manufacturers.contains(name) {
            manufacturers.append(name)
        }
    }

    private func addProduct(_ prod: Product) {
        if !productsCategoriesNames.contains(String(prod.categoryId)) {
            productsCategoriesNames.append(String(prod.categoryId))
        }
        if !productsIdNames.contains(String(prod.id)) {
            productsIdNames.append(String(prod.id))
        }
    }

    private func addContry(_ country: String) {
        if !countries.contains(country) {
            countries.append(country)
        }
    }

    private func addState(_ state: String) {
        if !statesName.contains(state) {
            statesName.append(state)
        }
    }

    //MARK: - Attributes
    // return the values for each requirement

    func getMostValuableBuilding() -> String {
        var max = 0.0
        var id = 0
        for build in buildingsValue {
            if build.value > max {
                max = build.value
                id = build.id
            }
        }
        return buildings.filter({ $0.id == id }).first?.name ?? ""
    }

    func getTotalForManufacturer(_ id: String) -> Double {
        let specifics = products.filter({ $0.manufacturerName == id })
        var total = 0.0
        for prod in specifics {
            total += prod.cost
        }
        return total
    }

    func getTotalForProduct(_ identifier: String) -> Int {
        let id = Int(identifier)
        return products.filter({ $0.id == id}).count
    }

    func getTotalForProductCategory(_ identifier: String) -> Double {
        let id = Int(identifier)
        let specifics = products.filter({ $0.categoryId == id})
        var total = 0.0
        for prod in specifics {
            total += prod.cost
        }
        return total
    }

    // Used inheritance to help retrieve information efficiently

    func getTotalForState(_ state: String) -> Double {
        let buildings = buildingsValue.filter({ $0.stateName == state})
        var total = 0.0
        for building in buildings {
            total += building.value
        }
        return total
    }

    func getTotalForCountry(_ country: String) -> Double {
        let buildings = buildingsValue.filter({ $0.countryName == country})
        var total = 0.0
        for building in buildings {
            total += building.value
        }
        return total
    }
}
