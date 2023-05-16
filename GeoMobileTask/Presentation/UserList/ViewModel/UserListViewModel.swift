//
//  UserList.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

class UserListViewModel: NSObject, ObservableObject, Identifiable {
   
    let title = "Books"
    @Published var users: [User] = []
    enum State {
        case finished
        case loading
    }
    
    @Published private(set) var error: String? = nil
    @Published private(set) var state = State.loading
    private let userLoader: UserLoader
    @Published var dataSource: [UserRowViewModel] = []
     
    
    init(userLoader: UserLoader) {
        self.userLoader = userLoader
        super.init()
        self.loadUsers()
    }
    

    
    func loadUsers() {
        state = .loading
        userLoader.load { [weak self] result in
            guard let self = self else { return }
            
        state = .finished
            switch result {
            case .success(let users):
                self.dataSource = users.map({ user in
                    return UserRowViewModel(item: user)
                })
                
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
