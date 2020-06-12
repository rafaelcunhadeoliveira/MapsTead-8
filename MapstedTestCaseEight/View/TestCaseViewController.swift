//
//  ViewController.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class TestCaseViewController: UIViewController {
    
    //MARK: - Variables
    var viewModel = TestCaseViewModel() // MVVM
    var group =  DispatchGroup() //Dispatch group to wait for both services to complete

    //MARK: - Outlets
    
    @IBOutlet weak var ManufactorerPickerView: UIPickerView!
    @IBOutlet weak var ManufactorerTotal: UILabel!
    @IBOutlet weak var CategoryPickerView: UIPickerView!
    @IBOutlet weak var CategoryTotal: UILabel!
    @IBOutlet weak var CountryPickerView: UIPickerView!
    @IBOutlet weak var CountryTotal: UILabel!
    @IBOutlet weak var StatePickerView: UIPickerView!
    @IBOutlet weak var StateTotal: UILabel!
    @IBOutlet weak var ItemPickerView: UIPickerView!
    @IBOutlet weak var ItemTotal: UILabel!
    @IBOutlet weak var BuildingNameLabel: UILabel!

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        getInfo()
    }

    //MARK: - Requests

    func getInfo() {
        getAnalytics()
        getBuildingData()
        group.notify(queue: .main) {
            self.setUp()
            self.hideLoading()
        }
    }
    
    func getAnalytics() {
        group.enter()
        viewModel.getAnalyticsData(success: {
            self.group.leave()
        }) { (error) in
            self.group.leave()
            self.hideLoading()
            self.showError(error.localizedDescription)
        }
    }
    
    func getBuildingData() {
        group.enter()
        viewModel.getBuildingData(success: {
            self.group.leave()
        }) { (error) in
            self.group.leave()
            self.hideLoading()
            self.showError(error.localizedDescription)
        }
    }

    // MARK: - Layout

    func setUp() {
        setMostValuableBuilding()
        setManufacturer()
        setProductCategory()
        setCountry()
        setState()
        setProductId()
    }
    
    func setMostValuableBuilding() {
        BuildingNameLabel.text = viewModel.getMostValuableBuilding()
    }
    
    func setManufacturer() {
        ManufactorerPickerView.dataSource = self
        ManufactorerPickerView.delegate = self
        setManufacturerTotal(viewModel.manufacturers.first ?? "")
    }
    
    func setManufacturerTotal(_ name: String) {
        ManufactorerTotal.text = String(viewModel.getTotalForManufacturer(name)).currencyFormatting()
    }
    
    func setProductCategory() {
        CategoryPickerView.dataSource = self
        CategoryPickerView.delegate = self
        setProductCategoryTotal(viewModel.productsCategoriesNames.first ?? "")
    }
    
    func setProductCategoryTotal(_ name: String) {
        CategoryTotal.text = String(viewModel.getTotalForProductCategory(name)).currencyFormatting()
    }
    
    func setCountry() {
        CountryPickerView.dataSource = self
        CountryPickerView.delegate = self
        setCountryTotal(viewModel.countries.first ?? "")
    }
    
    func setCountryTotal(_ name: String) {
        CountryTotal.text = String(viewModel.getTotalForCountry(name)).currencyFormatting()
    }
    
    func setState() {
        StatePickerView.dataSource = self
        StatePickerView.delegate = self
        setStateTotal(viewModel.statesName.first ?? "")
    }
    
    func setStateTotal(_ name: String) {
        StateTotal.text = String(viewModel.getTotalForState(name)).currencyFormatting()
    }
    
    func setProductId() {
        ItemPickerView.dataSource = self
        ItemPickerView.delegate = self
        setProductIdTotal(viewModel.productsIdNames.first ?? "")
    }
    
    func setProductIdTotal(_ name: String) {
        ItemTotal.text = String(viewModel.getTotalForProduct(name))
    }
}

extension TestCaseViewController: UIPickerViewDataSource {
    //Picker View controlled by tag setted on storyboard
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return viewModel.manufacturers.count
        case 1:
            return viewModel.productsCategoriesNames.count
        case 2:
            return viewModel.countries.count
        case 3:
            return viewModel.statesName.count
        case 4:
            return viewModel.productsIdNames.count
        default:
            return 0
        }
    }
}

extension TestCaseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return viewModel.manufacturers[row]
        case 1:
            return viewModel.productsCategoriesNames[row]
        case 2:
            return viewModel.countries[row]
        case 3:
            return viewModel.statesName[row]
        case 4:
            return viewModel.productsIdNames[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            setManufacturerTotal(viewModel.manufacturers[row])
        case 1:
            setProductCategoryTotal(viewModel.productsCategoriesNames[row])
        case 2:
            setCountryTotal(viewModel.countries[row])
        case 3:
            setStateTotal(viewModel.statesName[row])
        case 4:
            setProductIdTotal(viewModel.productsIdNames[row])
        default:
            break
        }
    }
}
