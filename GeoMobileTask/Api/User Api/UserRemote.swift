//
//  UserRemote.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

struct UserRemote: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
