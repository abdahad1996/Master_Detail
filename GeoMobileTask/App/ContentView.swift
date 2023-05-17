//
//  ContentView.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import SwiftUI

final class RootFactory {
    
    let remoteLoader: UserRemoteLoader = {
        let session = URLSession(configuration: .ephemeral)
        let httpClient = URLSessionHTTPClient(session: session)
        let url = URL(string: "https://reqres.in/api/users?per_page=10")!
        let remoteLoader = UserRemoteLoader(url: url, client: httpClient)
        return remoteLoader
    }()
    
    let localLoader:UserLocalLoader = {
        let localURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("user.store")
        let localStore = CodeableUserStore(storeURL: localURL)
        let localLoader = UserLocalLoader(store: localStore)
        return localLoader
        
    }()
    
}



struct ContentView: View {
    private let rootFactory = RootFactory()
    
    var body: some View {
       
        UserListView(viewModel: UserListViewModel(userLoader:MainQueueDispatchDecorator(decoratee: UserLoaderWithFallbackComposite(
            primary: UserLoaderCacheDecorator(
                decoratee:rootFactory.remoteLoader,
                cache:rootFactory.localLoader
            ),
            fallback:rootFactory.localLoader))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
