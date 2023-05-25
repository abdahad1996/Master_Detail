//
//  UserDetailView.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
import SwiftUI

struct AvatarView: View {
    let url: URL
    let size: CGFloat
    var body: some View {
        AsyncImage(url: url){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .cornerRadius(size/2)
        } placeholder: {
            Image(systemName: "photo.fill")
                .resizable()
                .frame(width: size/2, height: size/2)
           
        }
        .frame(width: size, height: size)
        .cornerRadius(size / 2)
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 4)
                .frame(width: size, height: size)
        )
        .shadow(radius: 3)
    }
}



struct UserDetailsView: View {
    
    @ObservedObject var viewModel: UserRowViewModel
    
    var body: some View {
        OSModeThemeProvider { palette in
            ScrollView(showsIndicators:false) {
                VStack(alignment: .center,spacing: 10) {
                    AvatarView(url: viewModel.avatar!, size: 300)
                    Text(viewModel.fullName).font(.title).foregroundColor(palette.primary).bold()
                    //                Text(viewModel.lastName).font(.headline).foregroundColor(.gray)
                    Text(viewModel.email).font(.headline).foregroundColor(palette.secondary)
                    //                Text(viewModel.id).font(.subheadline).foregroundColor(.gray)
                }
            }
        }
        .padding(.top, 20)
        .navigationBarTitle(viewModel.fullName)
    }
}
