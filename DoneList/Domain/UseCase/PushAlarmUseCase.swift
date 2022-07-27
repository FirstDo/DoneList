//
//  PushAlarmUseCase.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UserNotifications

protocol PushAlarmUseCaseType {
    func registerPushNotification(_ date: Date)
    func removePushNotification()
}

final class PushAlarmUseCase: PushAlarmUseCaseType {
    
    private let notificationManager: LocalNotificationManager
    
    init(notificationManager: LocalNotificationManager) {
        self.notificationManager = notificationManager
    }
    
    func registerPushNotification(_ date: Date) {
        notificationManager.registerNotification(target: date)
    }
    
    func removePushNotification() {
        notificationManager.removeAllNotification()
    }
}
