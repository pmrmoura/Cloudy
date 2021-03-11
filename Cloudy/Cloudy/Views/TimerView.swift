//
//  TimerView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 11/03/21.
//

import SwiftUI

struct TimerView: View {
    

    var body: some View {
        VStack {
            
            
      
            HeaderTimerView()
            
            Spacer()
            
            Timer()
            
            Spacer()
            
            ConcluirButton()
            
            Spacer()
            
        }.background(
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
    var selectedPause: String = "Yoga"
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
                            .frame(width: UIScreen.main.bounds.width*0.08)
                    })

            } .padding(.trailing, 20)
            
            
            Text("\(selectedPause)")
                .font(.custom("AvenirNext-Regular", size:30))
                .foregroundColor(Color.black) //aqui pode pegar a cor do figma e colocar o nome
                .padding(.leading, 40)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            
            Spacer()
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 105, alignment: .leading)
                
            
            Text("Você gostaria de fazer uma pausa de quanto tempo?")
            .font(.custom("AvenirNext-Regular", size:17))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .frame(width: UIScreen.main.bounds.width*0.60, alignment: .center)
        
            
        

    }
    
}

struct Timer: View {
    var body: some View {
        Text("Timer")

    }
   
}

struct ConcluirButton: View {
    var body: some View {
        Button(
            action: {
                //do it
            },
            label: {
                Image("bn-concluir")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width*0.3)
            })
            .foregroundColor(Color.blue)
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
