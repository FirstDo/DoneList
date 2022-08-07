//
//  FontCell.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct FontCell: View {
    
    @AppStorage("font") var currentFont: AppFont = FontManager.getFontName()
    @State var isPresented = false
    
    var body: some View {
        HStack {
            Image(systemName: "text.bubble")
                .foregroundColor(.teal)
            Text("글씨체 변경하기")
            Spacer()
            Text(currentFont.name)
        }
        .onTapGesture {
            isPresented = true
        }
        .confirmationDialog("글씨체", isPresented: $isPresented) {
            ForEach(AppFont.allCases, id: \.self) { font in
                Button {
                    currentFont = font
                    FontManager.setFont(font)
                } label: {
                    Text(font.name)
                }
            }
        }
    }
}

struct FontCell_Previews: PreviewProvider {
    static var previews: some View {
        FontCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.light)
        
        FontCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
    }
}
