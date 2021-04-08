//
//  TimerView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 11/03/21.
//

import SwiftUI
import Foundation
import UIKit
import UserNotifications


struct TimerView: View {
        
    @State var minSelected: Int = 1
    @State var didLaunchBefore: Bool = false
    @State var timeConfirmed: Bool = false
    @Binding var pause: PauseViewModel
    
    @ObservedObject var countDownTimer = TimerViewModel()

    var body: some View {
        VStack {
            
            HeaderTimerView(selectedPause: $pause, timerStarted: $didLaunchBefore, timeConfirmed: $timeConfirmed)
            
            Spacer()

            if (!timeConfirmed && !didLaunchBefore) {
                
                Picker("", selection: $minSelected){
             
                    ForEach(1..<60, id: \.self) { i in
                        Text("\(i) min").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.top, 10)
                .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                Button {
                    self.countDownTimer.minutes = minSelected
                    self.timeConfirmed.toggle()
                } label: {
                    Text("Confirmar")
                        .font(Font.custom("AvenirNext-Regular", size: 18))
                        .frame(width: 110, height: 45)
                        .foregroundColor(.white)
                        .background(Color("ButtonColor"))
                        .cornerRadius(32.0)
                }
                
                Spacer()
                
            } else {
                TimerCountDown(countDownTimer: self.countDownTimer, haveILaunched: $didLaunchBefore, pauseList: $pause)
                Spacer()
            }
            
        }.background( //VStack
            Image("bg-clouds")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
   
        )
    }
}

struct HeaderTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode:  Binding<PresentationMode>
    @State var closeTimerView: Bool = false
    @Binding var selectedPause: PauseViewModel
    @Binding var timerStarted: Bool
    @Binding var timeConfirmed: Bool
    
    @State var ConfirmedFeeling: Bool = false
    
    var timerStartedText = "Pausa iniciada, fica a vontade para bloquear seu celular e enviaremos uma notificação quando acabar"
    var timerNotStartedText = "Você gostaria de fazer uma pausa de quanto tempo?"

    var body: some View {
   
        VStack{
          
            HStack {
                
                Spacer()
                
                Button(
                    action: {
                        self.closeTimerView.toggle()
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Image("bn-close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.07, height: UIScreen.main.bounds.height*0.07)
                    })
                    .padding(.top, 50)

            }//HStack
            .padding(.trailing, 20)
           
            
            
            Text("\(selectedPause.name)")
                .font(.custom("AvenirNext-Regular", size:30))
                .foregroundColor(Color.black) //aqui pode pegar a cor do figma e colocar o nome
                .padding(.leading, 40)
                .padding(.bottom, 20)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            
            Spacer()
   
            } //VStack
            .frame(width: UIScreen.main.bounds.width, height: 105, alignment: .leading)
                
            
        Text(timerStarted ? timerStartedText : (timeConfirmed ? "Seu tempo de pausa é" : timerNotStartedText))
            .font(.custom("AvenirNext-Regular", size:17))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .padding(.top,30)
            .frame(width: UIScreen.main.bounds.width*0.60, alignment: .center)
           
    }
    
}

struct TimerCountDown: View {
    
    @State private var showFeelingView = false
    @ObservedObject var countDownTimer:TimerViewModel
    @Binding var pauseList: PauseViewModel
    @Binding var haveILaunched: Bool
    @State var buttonName: String = "INICIAR"
    @Environment(\.presentationMode) var presentationMode:  Binding<PresentationMode>
    let notifications: Notifications
    
    init(countDownTimer:TimerViewModel, haveILaunched: Binding<Bool>, pauseList: Binding<PauseViewModel>) {
        self.countDownTimer = countDownTimer
        self._haveILaunched = haveILaunched
        self._pauseList = pauseList
        self.notifications = Notifications(initialMinutes: countDownTimer.minutes)

    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("\(self.countDownTimer.minutes, specifier: "%02i"):\(self.countDownTimer.seconds, specifier: "%02i")")
                .font(Font.custom("AvenirNext-Regular", size: 32))
            
            Spacer()
            
            Button(
                action: {
                    if buttonName == "INICIAR" {
                        self.notifications.createNotification()
                        self.countDownTimer.startTimer()
                        self.buttonName = "CONCLUIR"
                        self.haveILaunched = true
                        
                    } else if buttonName == "CONCLUIR"{
                        self.notifications.deleteNotification()
                        self.countDownTimer.stopTimer()
                        self.showFeelingView = true
                        
                    } else {
                        self.notifications.deleteNotification()
                        self.countDownTimer.stopTimer()
                        self.presentationMode.wrappedValue.dismiss()
           
                    }
                },
                label: {
                    Text(buttonName)
                        .font(Font.custom("AvenirNext-Regular", size: 18))
                        .frame(width: 110, height: 45)
                        .foregroundColor(.white)
                        .background(Color("ButtonColor"))
                        .cornerRadius(32.0)
                }
            )
            .sheet(isPresented: $showFeelingView) {FeelingView(pause: $pauseList)}
            
            Spacer()
        }
        .onAppear(perform: {
            self.notifications.notificationsPermission()
        })
    }
}

