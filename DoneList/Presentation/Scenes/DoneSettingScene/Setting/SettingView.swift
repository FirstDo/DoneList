//
//  SettingView.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct SettingView<ViewModel>: View where ViewModel: SettingViewModelType {
    
    @AppStorage("font") var appFont: AppFont = FontManager.getFontName()
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Form {
                Section("앱 설정") {
                    PushAlarmCell()
                    FontCell()
                }
                .customFont(appFont, .body)
                
                Section {
                    AppStoreCell()
                    OpenSourceCell()
                } header: {
                    Text("기타")
                } footer: {
                    Text("developed by dudu")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                .customFont(appFont, .body)
            }
        }
        .navigationTitle("설정")
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
