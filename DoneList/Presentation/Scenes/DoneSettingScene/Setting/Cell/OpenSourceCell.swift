//
//  OpenSourceCell.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct OpenSourceCell: View {
    
    var body: some View {
            NavigationLink {
                OpenSourceListView(viewModel: OpenSourceListViewModel())
            } label: {
                Label("오픈소스 라이센스", systemImage: "doc.fill")
                    .tint(.blue)
            }
    }
}

struct ExtractedView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.light)
        
        OpenSourceCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
    }
}
