//
//  UserCache.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

 
public protocol UserCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ user: [User], completion: @escaping (Result) -> Void)
}
