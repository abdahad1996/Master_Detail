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
        switch viewModel.state  {
        case .loading:
            progressView
        default:
           
                listView
            
            
        }
        
    }
    
    
}

private extension UserListView {
    
    var listView: some View {
        OSModeThemeProvider { palette in
            
            NavigationView {
                
                if viewModel.dataSource.isEmpty {
                    emptyResultView
                } else {
                    
                    VStack {
                        Text("last updated at : \(viewModel.timeStamp)")
                            .foregroundColor(palette.accentColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
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
            viewModel.loadUsers()
        }
    }
    
    var emptyResultView: some View {
        OSModeThemeProvider { palette in
            NavigationView {
                AnyView(
                    
                    VStack {
                        Text("No Internet Connection")
                        Button(action: {
                            viewModel.loadUsers()
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
