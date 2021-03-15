//
//  AddPausePopUp.swift
//  Cloudy
//
//  Created by Pedro Moura on 12/03/21.
//

import SwiftUI

struct AddPausePopUp: View {
    @State var pauseName: String = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [Color("PopUpBackground"), Color("PopUpBackground2")]),
                           startPoint: .topLeading,
                           endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("O que você gostaria de fazer nessa pausa?")
                    .font(Font.custom("AvenirNext-Regular", size: 22))
                    .multilineTextAlignment(.center)
                    .padding()
                TextField("", text: $pauseName)
                    .overlay(Rectangle()
                                .frame(width: 250, height: 2)
                                .padding(.top, 35)
                                .foregroundColor(Color("TextFieldBorderColor"))
                    )
                HStack {
                    Button {
                        print("Cancelou")
                    } label: {
                        Text("Cancelar")
                    }
                    
                    Button {
                        print("Cancelou")
                    } label: {
                        Text("Adicionar")
                    }
                }
                .padding(.top, 32)
            }
        }
        .frame(width: 300, height: 250)
        .cornerRadius(16)
    }
}

struct AddPausePopUp_Previews: PreviewProvider {
    static var previews: some View {
        AddPausePopUp()
    }
}
