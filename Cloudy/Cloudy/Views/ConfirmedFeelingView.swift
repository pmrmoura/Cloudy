//
//  ConfirmedFeelingView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 08/04/21.
//

import SwiftUI

struct ConfirmedFeelingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var confirmedFeelingView: Bool = false
    @Binding var selectedPause: PauseViewModel
    @Binding var selectedFeeling: Int
    @Binding var currentScreen: String
    
    var images = ["energizado", "okay", "cansado"]
    
    var captions = ["Que bom que a sua pausa foi restauradora! Você sabia que pausas revigoram a mente e estimulam a criatividade?", "Parabéns por ter tirado um tempo para você! Você sabia que fazer uma pausa para se movimentar traz benefícios pra sua saúde física e mental?", "Talvez você precise de uma pausa mais longa... Tá tudo bem. Lembre de ser gentil com você mesmo."]
    
    var body: some View {
       
        VStack{
        
            HStack {
                
                Spacer()
                
                Button(
                    action: {
                        self.confirmedFeelingView.toggle()
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Image("bn-close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.07, height: UIScreen.main.bounds.height*0.07)
                    })
                
            }//HStack
            .padding(.trailing, 20)
        
            VStack{
    
                Subview(imageString: images[selectedFeeling])
                    .frame(width: UIScreen.main.bounds.width*0.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("\(selectedPause.name)")
                    .font(.custom("AvenirNext-Regular", size:30))
                    .foregroundColor(Color.black) //aqui pode pegar a cor do figma e colocar o nome
                    .padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                
                Text(self.captions[self.selectedFeeling])
                    .font(.custom("AvenirNext-Regular", size:17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width*0.6, alignment: .center)
                
                Spacer()
                
            } //VStack
            
            Button(
                action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                },
                label: {
                    Text("OK")
                        .font(Font.custom("AvenirNext-Regular", size: 18))
                        .frame(width: 120, height: 45)
                        .foregroundColor(.black)
                        .background(Image("bg-button").resizable().aspectRatio(contentMode: .fit))
                        .cornerRadius(32.0)
                        .padding(.bottom, 150)
                }
            )
            
            Spacer()
        }

        .background( //VStack
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            .frame(width: UIScreen.main.bounds.width, height: 75, alignment: .leading)
        )
        
    }
   
    
}
