//
//  UserLoaderCacheDecorator.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation
//decorating saving cache in loading functionality 
final class UserLoaderCacheDecorator: UserLoader {
    
    
    private let decoratee: UserLoader
    private let cache: UserCache
    
    init(decoratee: UserLoader, cache: UserCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load() async throws -> (UserLoader.Result) {
        let result = try await decoratee.load()
        switch result {
        case .success(let users):
            await self.cache.save(users)
            return .success(users)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
}
