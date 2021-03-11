//
//  AddPauseView.swift
//  Cloudy
//
//  Created by Pedro Moura on 11/03/21.
//

import SwiftUI

struct AddPauseView: View {
    var pauses: [Pause] = [Pause(name: "Pausa 1", image: "Cloud1")]

    var body: some View {
            VStack {
                Header()
                ScrollView {
                    LazyVStack {
                        Button {
                            print("oi")
                        } label : {
                            PauseItem(isButton: true, label: "Adicionar pausa")
                        }
                        
                        ForEach(pauses, id: \.id ) { pause in
                            PauseItem(label: pause.name)
                        }
                    }
                }
        
                Spacer()
            }
    }
}

struct Header: View {
    var body: some View {
        VStack {
            HStack {
                Text("Faça uma pausa")
                    .padding(.top, 22)
                    .padding(.leading, 42)
                    .font(Font.custom("AvenirNext-Regular", size: 32))
                Spacer()
            }
            
            HStack {
                Text("Que tal dedicar um tempinho para renovar suas energias")
                    .padding(.top, 12)
                    .padding(.leading, 42)
                    .font(Font.custom("AvenirNext-Regular", size: 20))
                Spacer()
            }
        }
    }
}

struct PauseItem: View {
    var isButton: Bool = false
    var label: String
    var body: some View {
        ZStack {
            Image("Cloud1")
                .opacity(isButton ? 0.6 : 1)
            VStack {
                Spacer()
                HStack {
                    Text(label)
                        .padding()
                        .foregroundColor(isButton ? .gray : .black)
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
        }
        .frame(width: 230, height: 150)
        .padding(.horizontal, 52)
    }
}

struct AddPauseView_Previews: PreviewProvider {
    static var previews: some View {
        AddPauseView()
    }
}
