//
//  Combine+UIControl.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit
import Combine

extension UIControl {
    
    func controlPublisher(for event: UIControl.Event) -> EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
    }
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscriber: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    fileprivate class EventSubscription<S: Subscriber>: Subscription where Never == S.Failure, UIControl == S.Input {
        
        let control: UIControl
        let event: UIControl.Event
        var subscriber: S?
        
        init(control: UIControl, subscriber: S, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscriber
            self.event = event
            
            control.addTarget(self, action: #selector(didOccurEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(didOccurEvent), for: event)
        }
        
        @objc func didOccurEvent() {
            _ = subscriber?.receive(control)
        }
    }
}
