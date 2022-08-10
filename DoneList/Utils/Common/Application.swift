//
//  Application.swift
//  DoneList
//
//  Created by dudu on 2022/08/10.
//

import UIKit

final class Application {
    static let shared = Application()
    private init() {}
    
    func openAppSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url) { _ in }
            }
        }
    }
}
