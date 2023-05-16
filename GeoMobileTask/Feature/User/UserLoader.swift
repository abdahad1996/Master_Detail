//
//  UserLoader.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

public protocol UserLoader {
    typealias Result = Swift.Result<[User], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
