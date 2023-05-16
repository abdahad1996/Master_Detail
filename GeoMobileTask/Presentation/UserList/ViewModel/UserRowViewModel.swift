//
//  UserRowViewModel.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
import SwiftUI

class UserRowViewModel: ObservableObject, Identifiable {
    private let item: User
    
    var identifier: Int {
        return item.id
    }
    
    var email: String {
        return item.email
    }
    
    var firstName: String {
        item.firstName
    }
    
    var lastName: String {
        item.lastName
    }
    
    var fullName:String{
        item.firstName + " " + item.lastName
    }
    
    var avatar: URL? {
    return URL(string: item.avatar)
        
    }
    
    init(item: User) {
        self.item = item
    }
}

extension UserRowViewModel: Hashable {
    static func == (lhs: UserRowViewModel, rhs: UserRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
