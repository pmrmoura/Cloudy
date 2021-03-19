//
//  Notifications.swift
//  Cloudy
//
//  Created by Pedro Moura on 18/03/21.
//

import UserNotifications

struct Notifications {
    var initialMinutes: Int
    let identifier = "PauseIdentifier"

    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pausa concluida"
        content.body = "Sua pausa foi concluida com sucesso"

        let triggerDate = Calendar.current.date(byAdding: .minute, value: initialMinutes, to: Date())
        let triggerDateComponents = Calendar.current.dateComponents([.weekday, .month, .year, .hour, .minute, .second], from: triggerDate!)
        let trigger = UNCalendarNotificationTrigger(
         dateMatching: triggerDateComponents, repeats: true)
        let req = UNNotificationRequest(identifier: self.identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
    func deleteNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.identifier])
    }
    
    func notificationsPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) {(_, _) in }
    }
}
