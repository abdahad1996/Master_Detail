//
//  UserRemoteLoader.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

import Foundation
final class UserRemoteLoader: UserLoader {
    
    typealias Result = UserLoader.Result
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() async throws -> (Result) {
        do {
            let (data,response) = try await client.get(from: url)
            let result = UserMapper.map(data, from: response)
            return result
        }catch(_){
            throw Error.connectivity
        }
        
        
        
    }
}

