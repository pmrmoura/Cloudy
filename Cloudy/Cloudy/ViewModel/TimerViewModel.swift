//
//  TimerViewModel.swift
//  Cloudy
//
//  Created by Juliano Vaz on 12/03/21.
//

import Foundation

class TimerViewModel {

    var seconds = 5 // Esta variável manterá um valor inicial de segundos. Pode ser qualquer valor acima de 0.
    var timer = Timer()
    var isTimerRunning = false // // Isso será usado para garantir que apenas um timer seja criado por vez. (Verifique se essa variável foi declarada na classe View Controller.)
    var resumeTapped = false
    var buttonImageControl = 0
    let emotionDescriptionText = ["Energizado", "Okay", "Cansado"]
    var minutesPicker = 0
    var secondsPicker = 0


func startButttonTapped(){
    if self.isTimerRunning == false && (minutesPicker != 0 || secondsPicker != 0) {
        // Pega a entrada do picker e passa para seconds
        self.seconds = self.secondsPicker
        self.seconds += self.minutesPicker * 60
        // Muda a label com do timer
//        timerLabel.text = String(format: "%02i : %02i", self.minutesPicker, self.secondsPicker)
//        runTimer()
//        self.startButton.isEnabled = false
//        self.phraseLabel.text = "Aproveite a sua pausa! \nVocê merece!"
//
//        self.timerView0.isHidden = true
//        self.timerView1.isHidden = false
    }
}

    func runTimer() {
        isTimerRunning = true
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
//        self.pauseButton.isEnabled = true
    }
//
    func updateTimer() {
        if seconds < 1 {
//            timer.invalidate()
            // Enviar alerta para indicar que o tempo acabou!!
//            self.pauseButton.isHidden = true
//            self.concludeButton.isHidden = false
//            self.phraseLabel.text = "Sua pausa acabou..."
        } else {
            seconds -= 1 // Isso diminuirá (contagem regressiva) os segundos
//            timerLabel.text = timeString(time: TimeInterval(seconds)) // Isso atualizará o rótulo
        }
    }

//func timeString(time: TimeInterval) -> String {
//    //let hours = Int(time) / 3600
//    let minutes = Int(time) / 60 % 60
//    let seconds = Int(time) % 60
//
//    return String(format: "%02i : %02i", minutes, seconds)
//}
}
