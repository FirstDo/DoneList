//
//  SettingView.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct SettingView<ViewModel>: View where ViewModel: SettingViewModelType {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Form {
                Section(viewModel.appSettingSectionHeader) {
                    FontCell()
                }
                .customFont(viewModel.appFont, .body)
                
                Section {
                    AppStoreCell()
                    OpenSourceCell()
                } header: {
                    Text(viewModel.otherSettingSectionHeader)
                } footer: {
                    Text(viewModel.otherSettingSectionFootter)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                .customFont(viewModel.appFont, .body)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView(viewModel: SettingViewModel())
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.large)
                .preferredColorScheme(.light)
        }
        
        NavigationView {
            SettingView(viewModel: SettingViewModel())
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.large)
                .preferredColorScheme(.dark)
        }
    }
}
