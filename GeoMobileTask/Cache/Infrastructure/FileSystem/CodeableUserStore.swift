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
        
        var localCategories: [UserLocal] {
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
    
    private let queue = DispatchQueue(label: "\(CodeableUserStore.self)Queue", qos: .userInitiated, attributes: .concurrent)
    private let storeURL: URL
    
    init(storeURL: URL) {
        self.storeURL = storeURL
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        let storeURL = self.storeURL
        queue.async {
            guard let data = try? Data(contentsOf: storeURL) else {
                return completion(.empty)
            }
            
            do {
                let decoder = JSONDecoder()
                let cache = try decoder.decode(Cache.self, from: data)
                completion(.found(categories: cache.localCategories))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func insert(_ orders: [UserLocal], completion: @escaping InsertionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {
            do {
                let encoder = JSONEncoder()
                let cache = Cache(users: orders.map(CodableUsers.init))
                let encoded = try encoder.encode(cache)
                try encoded.write(to: storeURL)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(completion: @escaping DeletionCompletion) {
        let storeURL = self.storeURL
        queue.async(flags: .barrier) {
            guard FileManager.default.fileExists(atPath: storeURL.path) else {
                return completion(nil)
            }
            
            do {
                try FileManager.default.removeItem(at: storeURL)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}
