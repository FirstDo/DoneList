//
//  AppStoreCell.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct AppStoreCell: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            NavigationLink("오픈소스 라이센스", isActive: .constant(false)) {
                
            }
        }
        .onTapGesture {
            // TODO: Show App Store Link
        }
    }
}

struct AppStoreCell_Previews: PreviewProvider {
    static var previews: some View {
        AppStoreCell()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
