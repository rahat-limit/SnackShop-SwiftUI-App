//
//  ValidationHelper.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

class ValidationHelper {
    func isValid(values: [String]) -> Bool {
        for value in values {
            if value.isEmpty {
                return false
            }
        }
        return true
    }
}
