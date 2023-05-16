//
//  ContentView.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
       UserListView(viewModel: UserListViewModel(userLoader: MainQueueDispatchDecorator(decoratee: UserRemoteLoader(url: URL(string: "https://reqres.in/api/users?per_page=10")!, client: URLSessionHTTPClient(session: .shared)))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
