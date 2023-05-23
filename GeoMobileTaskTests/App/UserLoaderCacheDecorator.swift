//
//  UserLoaderCacheDecorator.swift
//  GeoMobileTaskTests
//
//  Created by macbook abdul on 20/05/2023.
//

import Foundation
import XCTest
@testable import GeoMobileTask

 

class UserLoaderCacheDecoratorTests:XCTestCase{
    
   
    func testLoaderDeliversUsersOnSuccess(){
        let sut = makeSut(cache: CacheSpy(), result: .success(uniqueUserModel()))
        expect(sut, completeWith:.success(uniqueUserModel()))
         

    }
    
    func testLoaderDeliversErrors(){
        let sut = makeSut(cache: CacheSpy(), result: .success(uniqueUserModel()))
        expect(sut, completeWith:.failure(anyNSError()))
         
    }
    
    func testCacheUsersSavedOnLoadSuccess(){
        let cache = CacheSpy()
        let sut = makeSut(cache: cache, result: .success(uniqueUserModel()))
        
        sut.load { _ in
            
        }
        XCTAssertEqual(cache.messages.count, 1)

        
    }
    
    func testCacheUsersSavedOnLoadFailure(){
        let cache = CacheSpy()
        let sut = makeSut(cache: cache, result: .failure(anyNSError()))
        sut.load { _ in
            
        }
        XCTAssertEqual(cache.messages.count, 0)
    }
//
    
    private func makeSut(cache:UserCache,result:UserLoader.Result)->UserLoader{
        let decoratee = UserLoaderStub(result:result)
        let sut = UserLoaderCacheDecorator(decoratee:decoratee, cache: cache)
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
    
    private class CacheSpy:UserCache{
        var messages = [Message]()
        enum Message:Equatable{
            case save([User])
        }
        func save(_ user: [User], completion: @escaping (UserCache.Result) -> Void) {
            messages.append(.save(user))
            completion(.none)
        }
        
        
    }
    
}
