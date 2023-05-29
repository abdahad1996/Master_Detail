//
//  CodeableUserStore.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

import Foundation

final class CodeableUserStore: UserStore {
    
    private struct Cache: Codable {
        let users: [CodableUsers]
//        let timeStamp:
        
        var localUsers: [UserLocal] {
            return users.map { $0.local }
        }
    }
    
    private struct CodableUsers: Codable {
        private let id: Int
        private let firstName: String
        private let lastName: String
        private let email: String
        private let avatar:String

        init(_ category: UserLocal) {
            id = category.id
            firstName = category.firstName
            lastName = category.lastName
            email = category.email
            avatar = category.avatar


        }
        
        var local: UserLocal {
            return UserLocal(id: id, email: email, firstName: firstName, lastName: lastName, avatar: avatar)
        }
    }
    
    private let storeURL: URL
    
    init(storeURL: URL) {
        self.storeURL = storeURL
    }
    
    func retrieve() async -> RetrieveCachedUserResult {
        let storeURL = self.storeURL
        guard let data = try? Data(contentsOf: storeURL) else {
            return RetrieveCachedUserResult.empty
        }
        do {
            let decoder = JSONDecoder()
            let cache = try decoder.decode(Cache.self, from: data)
            return RetrieveCachedUserResult.found(localUsers: cache.localUsers)
           
        } catch {
            return RetrieveCachedUserResult.failure(error)
        }
    }
    
    func insert(_ orders: [UserLocal]) async throws {
        let storeURL = self.storeURL
        let encoder = JSONEncoder()
        let cache = Cache(users: orders.map(CodableUsers.init))
        let encoded = try encoder.encode(cache)
        try encoded.write(to: storeURL)
    }
    
    func delete() async throws {
        let storeURL = self.storeURL
            guard FileManager.default.fileExists(atPath: storeURL.path) else {
                return ()
            }
            try  FileManager.default.removeItem(at: storeURL)
        
    }
}
