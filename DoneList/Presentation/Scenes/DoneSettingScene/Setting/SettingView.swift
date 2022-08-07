//
//  SettingView.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Form {
                Section("앱 설정") {
                    Text("푸쉬 알람")
                    FontCell()
                }
                
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
            }
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
