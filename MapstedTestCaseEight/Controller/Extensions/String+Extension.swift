//
//  String+Extension.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-12.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

extension String {
    func currencyFormatting() -> String { // string formatter for currency
        if let value = Double(self) {
            let form = NumberFormatter()
            form.numberStyle = .currency
            form.maximumFractionDigits = 2
            if let str = form.string(for: value) {
                return str
            }
        }
        return ""
    }
}
