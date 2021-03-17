//
//  TimerView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 11/03/21.
//

import SwiftUI
import Foundation
import UIKit


struct TimerView: View {
        
    @State var secondCurrent: Int = 0
    @State var minSelected: Int = 0
    @State var didLaunchBefore: Bool = false
    @Binding var pause: Pause

    var body: some View {
        VStack {
            
            HeaderTimerView(selectedPause: $pause)
            
            Spacer()

            if self.minSelected == 0  && self.secondCurrent == 0 && !didLaunchBefore {
                
                Picker("", selection: $minSelected){
             
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) min").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.top, 10)
                .frame(width: 100, height: 100, alignment: .center)
                
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

struct TimerCountDown: View {
    
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var haveILaunched: Bool
    @State var timerIsPaused: Bool = true
    @State var buttonName: String = "INICIAR"
    @State var timer: Timer? = nil
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("\(minutes, specifier: "%02i"):\(seconds, specifier: "%02i")")
                .bold()
            
            Spacer()
            
            Button(
                action: {
                    if buttonName == "INICIAR" {
                        self.startTimer()
                        self.buttonName = "CONCLUIR"
                        self.haveILaunched = true
                        
                    } else {
                        self.stopTimer()
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
    }
    

    func startTimer(){
        print("Entrou no start")
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            
            if self.seconds == 0 && self.minutes == 0 {
                stopTimer()
            }
            
           else if self.seconds == 0 {
                self.seconds = 59
                if self.minutes == 0 {
                    self.minutes = 59
                } else {
//                    if(self.minutes != 1){
                        self.minutes = self.minutes - 1
//                    }
                }
            } else {
                self.seconds = self.seconds - 1
            }
        }
    }
    
    func stopTimer(){
        print("Entrou no stop")
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
        self.minutes = 0
        self.seconds = 0
        
    }
    
}


struct Time {
    var hour: Int
    var minute: Int
    var second: Int = 0
}


struct HeaderTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var closeTimerView: Bool = false
    @Binding var selectedPause: Pause
    //essa variavel sera do tipo binding recebendo da tela AddPauseView
    
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
                
            
            Text("Você gostaria de fazer uma pausa de quanto tempo?")
            .font(.custom("AvenirNext-Regular", size:17))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .padding(.top,30)
            .frame(width: UIScreen.main.bounds.width*0.60, alignment: .center)
           
    }
    
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
