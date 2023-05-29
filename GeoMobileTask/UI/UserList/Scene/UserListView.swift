//
//  UserListView.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            switch viewModel.state  {
            case .loading:
                progressView
            default:
                    listView
                
            }
        }
         .task {
            await viewModel.loadUsers()
        }
    }
        
    
    
}

private extension UserListView {
    @discardableResult
    func loadUsers() -> Task<(), Never> {
        return Task{
            await viewModel.loadUsers()
        }
    }
    
    var listView: some View {
        OSModeThemeProvider { palette in
            
            NavigationView {
                
                if viewModel.dataSource.isEmpty {
                    emptyResultView
                } else {
                    
                    VStack {
                        List(viewModel.dataSource, id: \.self) { character in
                            NavigationLink(destination: UserDetailsView(viewModel: character)) {
                                UserRowView(item: character)
                            }
                        }
                        .listStyle(.automatic)
                    }
                    .navigationBarTitle("Users List")
                    
                }
                
            }
        }
         
        .refreshable {
            loadUsers()
         }
    }
    
    var emptyResultView: some View {
        OSModeThemeProvider { palette in
            NavigationView {
                AnyView(
                    
                    VStack {
                        Text("No Internet Connection")
                        Button(action: {
                            loadUsers()
                        }) {
                            Text("Retry")
                                .padding()
                                .background(palette.error)
                                .foregroundColor(palette.primary)
                                .cornerRadius(10)
                        }
                    }
                    
                )}}
        .navigationBarTitle("Users List")
    }
    
    var progressView: some View {
        ProgressView()
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: UserListViewModel(userLoader: UserRemoteLoader(url: URL(string: "https://reqres.in/api/users?per_page=10")!, client: URLSessionHTTPClient(session: URLSession.shared))))
    }
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
