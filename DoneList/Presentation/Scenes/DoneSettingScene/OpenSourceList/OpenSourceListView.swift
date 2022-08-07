//
//  OpenSourceListView.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct OpenSourceListView<ViewModel>: View where ViewModel: OpenSourceListViewModelType {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.openSources, id: \.self) { openSource in
            NavigationLink(openSource.name) {
                OpenSourceView(viewModel: OpenSourceViewModel(openSource: openSource))
            }
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

struct OpenSourceListView_Previews: PreviewProvider {
    
    static let viewModel = OpenSourceListViewModel()
    
    static var previews: some View {
        NavigationView {
            OpenSourceListView(viewModel: viewModel)
                .navigationTitle(viewModel.navigationTitle)
        }
    }
}
