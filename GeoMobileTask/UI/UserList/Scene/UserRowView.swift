//
//  UserRowView.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
import SwiftUI

struct UserRowView: View {
    var item: UserRowViewModel
    
    var body: some View {
        let imageURL = item.avatar
        
        OSModeThemeProvider { palette in
            HStack(alignment: .center, spacing: 8) {
                AsyncImage(url: imageURL)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4, content: {
    //                HStack(alignment: .center,spacing: 4) {
                    Text(item.fullName).font(.headline).foregroundColor(palette.primary).bold()
                    Text(item.email).font(.caption).foregroundColor(palette.secondary)
    //                }
                 })
                Spacer()
            }
        }
        
        .padding(4)
    }
}
