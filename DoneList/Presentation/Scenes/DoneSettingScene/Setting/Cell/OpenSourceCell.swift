//
//  OpenSourceCell.swift
//  DoneList
//
//  Created by 김도연 on 2022/08/07.
//

import SwiftUI

struct OpenSourceCell: View {
    
    var body: some View {
        HStack {
            Image(systemName: "doc.on.doc.fill")
                .foregroundColor(.blue)
            
            NavigationLink("오픈소스 라이센스") {
                OpenSourceListView(viewModel: OpenSourceListViewModel())
            }
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
