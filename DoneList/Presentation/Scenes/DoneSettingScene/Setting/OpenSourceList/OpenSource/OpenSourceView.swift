//
//  OpenSourceView.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct OpenSourceView<ViewModel>: View where ViewModel: OpenSourceViewModelType {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            Text(viewModel.openSource.content)
                .customFont(viewModel.appFont, .body)
        }
        .padding()
        .navigationTitle(viewModel.openSource.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        let openSource = OpenSource.allOpenSources.first!
        
        NavigationView {
            OpenSourceView(viewModel: OpenSourceViewModel(openSource: openSource))
                .navigationTitle(openSource.name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
