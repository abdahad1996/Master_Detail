//
//  UserLoaderWithFallBackComposite.swift
//  GeoMobileTaskTests
//
//  Created by macbook abdul on 18/05/2023.
//

import Foundation
import XCTest
@testable import GeoMobileTask
 
class UserLoaderStub:UserLoader{
    private let result:UserLoader.Result
    
    init(result: UserLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (UserLoader.Result) -> Void) {
        completion(result)
    }
    
    
}

class UserLoaderWithFallBackCompositeTests:XCTestCase{
    
    
    
    func test_load_Primary_Success(){
        let primaryUsers = uniqueUserModel()
        let secondaryUsers = uniqueUserModel()

        let sut =  makeSUT(primaryResult: .success(primaryUsers), fallbackResult: .failure(anyNSError()))
        expect(sut, completeWith:.success(uniqueUserModel()))

    }
    
    func test_load_fallback_OnPrimaryLoaderfailure(){
        let primaryUsers = uniqueUserModel()
        let secondaryUsers = uniqueUserModel()

        let sut =  makeSUT(primaryResult: .success(uniqueUserModel()), fallbackResult: .failure(anyNSError()))
        expect(sut, completeWith:.success(uniqueUserModel()))


    }
    
    func test_load_deliversErrorOnPrimaryAndFallbackLoaderFailure() {
        let primaryUsers = uniqueUserModel()
        let secondaryUsers = uniqueUserModel()

        let sut =  makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))
        expect(sut, completeWith:.failure(anyNSError()))

    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: UserLoader.Result, fallbackResult: UserLoader.Result, file: StaticString = #file, line: UInt = #line) -> UserLoader {
        let primaryLoader = UserLoaderStub(result: primaryResult)
        let fallbackLoader = UserLoaderStub(result: fallbackResult)
        let sut = UserLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeacks(primaryLoader, file: file, line: line)
        trackForMemoryLeacks(fallbackLoader, file: file, line: line)
        trackForMemoryLeacks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(_ sut: UserLoader,completeWith:UserLoader.Result) {
        var exp = expectation(description: "wait for UserLoaderWithFallbackComposite load completion")
        
        sut.load { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users,uniqueUserModel())
            case .failure(let err):
                print(err)
                
            }
            
            
            exp.fulfill()
        }
        wait(for: [exp],timeout: 1)
    }
}


