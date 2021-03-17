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
        
    @State var secondCurrent: Int = 0
    @State var minSelected: Int = 0
    @State var didLaunchBefore: Bool = false
    @State var timeConfirmed: Bool = false
    @Binding var pause: Pause

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
                TimerCountDown(minutes: $minSelected, seconds: $secondCurrent, haveILaunched: $didLaunchBefore)
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
    
    @Environment(\.presentationMode) var presentationMode
    @State var closeTimerView: Bool = false
    @Binding var selectedPause: Pause
    @Binding var timerStarted: Bool
    @Binding var timeConfirmed: Bool
    
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
    
    @Binding var minutes: Int
    @Binding var seconds: Int
    @State var start = false
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Binding var haveILaunched: Bool
    @State var buttonName: String = "INICIAR"
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("\(minutes, specifier: "%02i"):\(seconds, specifier: "%02i")")
                .font(Font.custom("AvenirNext-Regular", size: 32))
            
            Spacer()
            
            Button(
                action: {
                    if buttonName == "INICIAR" {
                        start.toggle()
                        self.buttonName = "CONCLUIR"
                        self.haveILaunched = true
                        
                    } else {
                        self.start.toggle()
                        presentation.wrappedValue.dismiss()
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
            Spacer()
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) {(_, _) in }
        })
        .onReceive(timer, perform: { _ in
            if (self.start) {
                if (self.seconds == 0 && self.minutes == 0) {
                    self.start.toggle()
                    self.Notify()
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
        })
    }
    
    func Notify() {
        let content = UNMutableNotificationContent()
        content.title = "Pausa concluida"
        content.body = "Sua pausa foi concluida com sucesso"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        
    }
}

