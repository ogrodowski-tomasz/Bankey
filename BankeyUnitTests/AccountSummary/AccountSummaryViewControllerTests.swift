//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Tomasz Ogrodowski on 14/12/2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    
    class MockProfileManager: ProfileManagerable {
        var profile: Profile?
        var error: NetworkingError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkingError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded() // triggers calling viewDidLoad()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func test_TitleAndMessage_ServerError() {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func test_TitleAndMessage_DecodingError() {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not proccess your request. Please try again.", titleAndMessage.1)
    }
    
    func test_Alert_ServerError() {
        mockManager.error = NetworkingError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func test_Alert_DecodingError() {
        mockManager.error = NetworkingError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not proccess your request. Please try again.", vc.errorAlert.message)
    }
    
}
