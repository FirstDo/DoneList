//
//  LocalNotificationManager.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UserNotifications
import UIKit

final class LocalNotificationManager {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        userNotificationCenter.requestAuthorization(options: [.sound, .badge, .alert]) { state, error in
            // TODO: true false에 따라서 userdefault값 바꿔주기
        }
    }
    
    func registerNotification(target date: Date) {
        userNotificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url) { _ in }
                    }
                }
                
            case .authorized, .provisional:
                let content = UNMutableNotificationContent()
                content.title = "notificaiton의 제목입니다"
                content.body = "notification의 body입니다"
                content.subtitle = "notification의 부제목입니다"
                content.sound = .default
                
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                self.userNotificationCenter.add(request)
            default:
                break
            }
        }
    }

    func removeNotification() {
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
}
