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
    
    func load(completion: @escaping (UserLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            completion(result.map { users in
                self?.cache.saveIgnoringResult(users)
                return users
            })
        }
    }
}

private extension UserCache {
    func saveIgnoringResult(_ users: [User]) {
        save(users) { _ in }
    }
}
