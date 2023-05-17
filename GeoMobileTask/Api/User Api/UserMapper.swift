//
//  UserMapper.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
enum UserMapper {
    struct UserRootResponse: Codable {
        let data: [UserRemote]
        
        private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
        
        var users : [User] {
            data.map({
                User(id: $0.id, email: $0.email, firstName: $0.firstName, lastName: $0.lastName, avatar: $0.avatar)
            })
        }
    }
    
    
    

    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse)  -> UserLoader.Result {
        guard response.statusCode == OK_200,
              let items = try? JSONDecoder().decode(UserRootResponse.self, from: data) else {
            return .failure(UserRemoteLoader.Error.invalidData)
        }
        
        return .success(items.users)
    }
}

 
