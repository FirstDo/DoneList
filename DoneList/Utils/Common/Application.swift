//
//  Application.swift
//  DoneList
//
//  Created by dudu on 2022/08/10.
//

import UIKit

final class Application {
    static let shared = Application()
    private let appID = "1639376972"
    
    private init() {}
    
    func openAppStore() {
        let urlString = "itms-apps://itunes.apple.com/app/" + appID
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url)
    }
}
