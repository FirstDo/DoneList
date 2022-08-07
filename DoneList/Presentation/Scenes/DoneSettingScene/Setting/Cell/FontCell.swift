//
//  FontCell.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct FontCell: View {
    @State var currentFont = "SystemFont"
    @State var isPresented = false
    
    var body: some View {
        HStack {
            Image(systemName: "text.bubble")
                .foregroundColor(.teal)
            Text("글씨체 변경하기")
            Spacer()
            Text(currentFont)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .onTapGesture {
            isPresented = true
        }
        .confirmationDialog("글씨체", isPresented: $isPresented) {
            ForEach(["Font1", "Font2", "Font3"], id: \.self) { font in
                Button(font) {
                    currentFont = font
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
