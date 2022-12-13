//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Tomasz Ogrodowski on 12/12/2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
