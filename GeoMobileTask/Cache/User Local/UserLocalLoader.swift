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
    public func save(_ user: [User]) async {
        do{
            try await store.delete()
            try await store.insert(user.toLocal())
        }catch (let err){
            print(err.localizedDescription)
        }
         
    }
    
    

    
}

extension UserLocalLoader: UserLoader {
    public func load() async throws -> (UserLoader.Result) {
     let result =  await store.retrieve()
        switch result {
        case let .failure(error):
            return .failure(error)
        
        case let .found(localUsers):
            return .success(localUsers.toDomain())
 
        case .empty:
            return .success([])
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
