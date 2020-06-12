//
//  Array+Extension.swift
//  MapstedTestCaseEight
//
//  Created by Rafael Cunha de Oliveira on 2020-06-11.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

extension Array where Element == BuildingValue { // check if the element already exists
    mutating func appendUnique(_ element: BuildingValue) {
        if let exists = filter({$0.id == element.id}).first {
            exists.value += element.value // if so, add the new value
        } else {
            append(element) // if not, add the element to the array
        }
    }
}
