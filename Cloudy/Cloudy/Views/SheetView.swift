//
//  SheetView.swift
//  Cloudy
//
//  Created by Pedro Moura on 16/03/21.
//

import SwiftUI

class AddNewPauseData: ObservableObject {
    @Published var name: String = ""
    @Published var image: String = "Cloud1"
}

struct SheetView: View {
    
    @ObservedObject var newData = AddNewPauseData()
    private let viewModel = AddNewPauseViewModel()
    
    
    @State var pauseName: String = ""
    @ObservedObject var pauseListVM: PauseListViewModel

    @ObservedObject var keyboard = KeyboardResponder()
    @EnvironmentObject var modalManager: ModalManager

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: CGFloat(5.0/2))
                    .frame(width: 40, height: 5)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .frame(height: 20)
            .padding()
            .offset(y: 15)
            
            Spacer()
            
            VStack {
                Text("O que você gostaria de fazer nessa pausa?")
                    .font(Font.custom("AvenirNext-Regular", size: 22))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 300)
                    .fixedSize(horizontal: false, vertical: true)
                
                TextField("", text: $pauseName)
                    .overlay(
                        Rectangle()
                            .frame(width: 250, height: 2)
                            .padding(.top, 35)
                            .foregroundColor(Color("TextFieldBorderColor"))
                    )
                    .frame(width: 250, height: 32)
                    .disableAutocorrection(true)

                VStack {
                    Button {
                        if (pauseName != "") {
                            viewModel.savePause(pause: PauseViewModel(id: UUID(), name: self.pauseName, image: newData.image))
                            print("adicionou pausa na sheet")
                            print(DataManager.shared.getPauses())
                            self.pauseListVM.fetchAllPauses()
                            self.pauseName = ""
                            self.modalManager.closeModal()
                            UIApplication.shared.endEditing()

                        }
                    } label: {
                        Text("SALVAR")
                            .font(Font.custom("AvenirNext-Regular", size: 18))
                            .frame(width: 120, height: 45)
                            .foregroundColor(.black)
                            .background(Image("bg-button").resizable().aspectRatio(contentMode: .fit))
                            .cornerRadius(32.0)
                    }
                    
                    Button {
                        self.pauseName = ""
                        self.modalManager.closeModal()
                    } label: {
                        Text("FECHAR")
                            .font(Font.custom("AvenirNext-Regular", size: 18))
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .padding(.top, 32)
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(.bottom)
                .animation(.easeOut)
            }
            
            Spacer()
        }.cornerRadius(32.0)
    }
    
    
}
