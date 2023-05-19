//
//  GeoMobileTaskTests.swift
//  GeoMobileTaskTests
//
//  Created by macbook abdul on 18/05/2023.
//

import XCTest
@testable import GeoMobileTask
final class GeoMobileEndToEndTests: XCTestCase {

    
    
    
    func test_endToEndGetUsersFromPublicApi_givesListOfUsers(){
        switch getUsersResult() {
        case let .success(users):
            XCTAssertEqual(users.count, 10, "Expected 10 users")
//            XCTAssertEqual(categories[0], expectedItem(at: 0))
//            XCTAssertEqual(categories[1], expectedItem(at: 1))
//            XCTAssertEqual(categories[2], expectedItem(at: 2))
            
        case let .failure(error):
            XCTFail("Expected successful Users result, got \(error) instead")
        
        default:
            XCTFail("Expected successful Users result, got no result instead")
        }
    }

    
    //MARK: helpers
    private func getUsersResult(file: StaticString = #filePath, line: UInt = #line)->UserLoader.Result?{
        
        let httpClient = URLSessionHTTPClient(session: URLSession.shared)
        let url = URL(string: "https://reqres.in/api/users?per_page=10")!
        let remoteLoader = UserRemoteLoader(url: url, client: httpClient)
        trackForMemoryLeacks(httpClient, file: file, line: line)
        trackForMemoryLeacks(remoteLoader, file: file, line: line)
        
        var receivedResult:UserLoader.Result?
        let exp  = expectation(description: "Wait for load completion")

        remoteLoader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)

        return receivedResult
        
    }
}
