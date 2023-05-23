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
    
    var emptyResultView: some View {
        NavigationView {
            AnyView(
//                Button(action: {
//                    //                               onCarTap?()
//                    viewModel.loadUsers()
//                }, label: {
//                    Text("No Internet Tap To  Retry")
//                        .font(.largeTitle)
//                        .foregroundColor(.gray)
//                        .background(.red)
//                })
//                //                Text("No results")
//                //                .font(.largeTitle)
//                //                .foregroundColor(.gray))
//            )
                
                VStack {
                            Text("No Internet Connection")
                            Button(action: {
                                                    viewModel.loadUsers()

                                // Retry action
//                                retryCount += 1
                                // Add your retry logic here
                            }) {
                                Text("Retry")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
            
        )}
        .navigationBarTitle("Users List")
    }
    
    var progressView: some View {
        ProgressView()
    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(viewModel: UserListViewModel(userLoader: UserRemoteLoader(url: "", client: URLSessionHTTPClient(.shared)))
//    }
//}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
