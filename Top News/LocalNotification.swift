//
//  LocalNotification.swift
//  Top News
//
//  Created by Egor on 07.09.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotification{
    
    class func scheduleNotification(){
        LocalNotification.removeNotifications(with: ["EverydayNews"])
        
        let content = UNMutableNotificationContent()
        content.title = "The topest news are waitig for you"
        content.body = "Don't miss new tidings from your favourite sources"
        content.sound = UNNotificationSound.default()
        
        let date = Date(timeIntervalSinceNow: 43_200)
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest(identifier: "EverydayNews", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    class func removeNotifications(with identifier: [String]){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifier)
        
    }
}

