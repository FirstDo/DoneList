//
//  AppStoreCell.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct AppStoreCell: View {
    
    @AppStorage("font") var currentFont: AppFont = FontManager.getFontName()
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            NavigationLink("앱 리뷰 남기러 가기", isActive: .constant(false)) {
                
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
            .preferredColorScheme(.light)
        
        AppStoreCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
        
    }
}
