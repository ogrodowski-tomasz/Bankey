//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Tomasz Ogrodowski on 12/12/2022.
//

import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTests: XCTestCase {
        
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func test_CurrencyFormatter_BreakIntoDollarsAndCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func test_CurrencyFormatter_DollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func test_CurrencyFormatter_ZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
}
