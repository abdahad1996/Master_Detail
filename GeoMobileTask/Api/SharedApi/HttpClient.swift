//
//  HttpClient.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

import Foundation

public protocol HTTPClient {
    typealias Result = (Data, HTTPURLResponse)
    
    @discardableResult
    func get(from url:URL) async throws -> Result
}
