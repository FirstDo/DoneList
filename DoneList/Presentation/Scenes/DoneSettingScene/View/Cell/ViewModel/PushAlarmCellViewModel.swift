//
//  PushAlarmCellViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import Foundation
import Combine

protocol PushAlarmCellViewModelInput {
    func didOnSwitch()
    func didOffSwitch()
    func didChangeDate(to date: Date)
}

protocol PushAlarmCellViewModelOutput {
    var switchState: CurrentValueSubject<Bool, Never> { get }
    var alarmDate: CurrentValueSubject<Date, Never> { get }
}

protocol PushAlarmCellViewModelType: PushAlarmCellViewModelInput, PushAlarmCellViewModelOutput {}

final class PushAlarmCellViewModel: PushAlarmCellViewModelType {
    private let pushAlarmUseCase: PushAlarmUseCaseType
    private var cancellableBag = Set<AnyCancellable>()
    // MARK: - Output
    
    let switchState: CurrentValueSubject<Bool, Never>
    let alarmDate: CurrentValueSubject<Date, Never>
    
    init(pushAlarmUseCase: PushAlarmUseCaseType, switchState: Bool, alarmDate: Date) {
        self.pushAlarmUseCase = pushAlarmUseCase
        self.switchState = CurrentValueSubject<Bool, Never>(switchState)
        self.alarmDate = CurrentValueSubject<Date, Never>(alarmDate)
    }
}

// MARK: - Input

extension PushAlarmCellViewModel {
    func didOnSwitch() {
        switchState.send(true)
        pushAlarmUseCase.registerPushNotification(alarmDate.value)
    }
    
    func didOffSwitch() {
        switchState.send(false)
        pushAlarmUseCase.removePushNotification()
    }
    func didChangeDate(to date: Date) {
        alarmDate.send(date)
        pushAlarmUseCase.registerPushNotification(alarmDate.value)
    }
}

