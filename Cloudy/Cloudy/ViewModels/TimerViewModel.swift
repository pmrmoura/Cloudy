//
//  ViewModel.swift
//  Cloudy
//
//  Created by Pedro Moura on 18/03/21.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    var timer = Timer()
    
    var initialDate = Date()
    
    private var initialMinutes = 0
    
    func startTimer() {
        self.initialMinutes = self.minutes
        self.initialDate = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.handleTimerInBackground()
            if (self.seconds <= 0 && self.minutes <= 0) {
                self.timer.invalidate()
                self.seconds = 0
                self.minutes = 0
            } else if (self.seconds == 0) {
                self.seconds = 59
                if (self.minutes == 0) {
                    self.minutes = 59
                } else {
                    self.minutes -= 1
                }
            } else {
                self.seconds -= 1
            }
        }
    }
    
    func stopTimer() {
        self.timer.invalidate()
    }
    
    func handleTimerInBackground() {
        let applicationState: UIApplication.State = UIApplication.shared.applicationState
    
        switch applicationState {
        case .active:
            print("Active")
        
        case .inactive:
            print("App acabou de fechar")
        
        case .background:
            print("App will be opened")
            
            let timerPassed = Date().timeIntervalSince(initialDate)
            
            let initialMinutesInSeconds = self.initialMinutes * 60
            
            let secondsPassedWhileInBackground = initialMinutesInSeconds - Int(timerPassed)
            
            let (minutes, seconds) = secondsToHoursMinutesSeconds(seconds: secondsPassedWhileInBackground)
    
            if (self.seconds >= 0) {
                print(self.seconds)
                self.minutes = minutes
                self.seconds = seconds
            }
        
        @unknown default:
            print("Unknown state")
        }
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
