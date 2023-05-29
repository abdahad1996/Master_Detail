//
//  UserStore.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

public enum RetrieveCachedUserResult {
    case empty
    case found(localUsers: [UserLocal])
    case failure(Error)
}

public protocol UserStore {
    
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedUserResult) -> Void
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
//    @available(*, renamed: "delete()")
//    func delete(completion: @escaping DeletionCompletion)
    
    func delete() async throws
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
//    @available(*, renamed: "insert(_:)")
//    func insert(_ orders: [UserLocal], completion: @escaping InsertionCompletion)
    
    func insert(_ orders: [UserLocal]) async throws
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to approprate threads, if needed.
//    @available(*, renamed: "retrieve()")
//    func retrieve(completion: @escaping RetrievalCompletion)
    
    func retrieve() async -> RetrieveCachedUserResult
    
}
