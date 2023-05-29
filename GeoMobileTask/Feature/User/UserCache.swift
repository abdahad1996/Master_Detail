//
//  UserCache.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

 
public protocol UserCache {    
    func save(_ user: [User]) async 
}
