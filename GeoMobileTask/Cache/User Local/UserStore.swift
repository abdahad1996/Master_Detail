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
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
//    typealias RetrievalResult = Result<[UserLocal?], Error>
    typealias RetrievalCompletion = (RetrieveCachedUserResult) -> Void
    
    
    /// Completion handler can be invoked in any threads.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ orders: [UserLocal], insertionCompletion: @escaping InsertionCompletion)
    
    /// Completion handler can be invoked in any threads.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}
