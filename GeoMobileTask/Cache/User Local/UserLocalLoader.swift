//
//  UserLocalLoader.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

public final class UserLocalLoader {
    private let store: UserStore
    public init(store: UserStore) {
        self.store = store
    }
}

extension UserLocalLoader: UserCache {
    
    public typealias SaveResult = Result<Void, Error>
    
    public func save(_ users: [User], completion: @escaping (UserCache.Result) -> Void) {
        store.delete  { [weak self] error in
            guard let self = self else { return }
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(users, with: completion)            }
        }
         
    }
    
    private func cache(_ users: [User], with completion: @escaping (UserCache.Result) -> Void) {
        store.insert(users.toLocal(), completion: { [weak self] error in
            guard let _ = self else { return }
            completion(error)
        })
    }
    
}

extension UserLocalLoader: UserLoader {
    
 
    public func load(completion: @escaping (UserLoader.Result) -> Void) {
        store.retrieve { [weak self] result in
            guard let _ = self else { return }
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            
            case let .found(localUsers):
                completion(.success(localUsers.toDomain()))
                
            case .empty:
                completion(.success([]))
            }
        }
    }
    
}


private extension Array where Element == User {
    func toLocal() -> [UserLocal] {
        return map{ UserLocal(id: $0.id, email: $0.email, firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar)}
    }
}

private extension Array where Element == UserLocal {
    func toDomain()  -> [User] {
        return map{ User(id: $0.id, email: $0.email, firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar) }
    }
}
