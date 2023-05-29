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
//    @Published private(set) var timeStamp:String = ""

    private let userLoader: UserLoader
    @Published var dataSource: [UserRowViewModel] = []
     
    
    init(userLoader: UserLoader)  {
        self.userLoader = userLoader
        super.init()
//        Task.init {
//           await self.loadUsers()
//        }
        
    }
     @MainActor
    func loadUsers() async{
        do {
            state = .loading
            let result = try await userLoader.load()
            state = .finished
            mapToUserRowViewModel(result)
        }catch(let error){
            self.error = error.localizedDescription
        }
    }
    
    fileprivate func mapToUserRowViewModel(_ result: (Result<[User], Error>)) {
        switch result {
            
        case .success(let users):
            self.dataSource = users.map({ user in
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MMM d, h:mm a"
//
//                self.timeStamp = dateFormatter.string(from: Date.init())
                return UserRowViewModel(item: user)
            })
            
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
}
