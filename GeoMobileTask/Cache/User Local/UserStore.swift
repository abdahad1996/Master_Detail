//
//  UserStore.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

public enum RetrieveCachedUserResult {
    case empty
    case found(categories: [UserLocal])
    case failure(Error)
}

public protocol UserStore {
    
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedUserResult) -> Void
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
    func delete(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
    func insert(_ orders: [UserLocal], completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
    
}
