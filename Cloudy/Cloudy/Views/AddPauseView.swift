//
//  AddPauseView.swift
//  Cloudy
//
//  Created by Pedro Moura on 11/03/21.
//

import SwiftUI

struct AddPauseView: View {
    @EnvironmentObject var modalManager: ModalManager
    @ObservedObject var pauseListVM = PauseListViewModel()
    

    @State var text: String = ""
//    @State var onDisappearFlag: false
    @State var pauses: [PauseViewModel] = []
    @State var showSheet: Bool = false
    @State var selectedPause: PauseViewModel = PauseViewModel(id: UUID.init(), name: "Default", image: "Cloud1")
    var body: some View {
        ZStack {
            VStack {
                Header()
                ScrollView {
                    LazyVStack { //isso pode ser problematico quando for deletar https://www.hackingwithswift.com/forums/swiftui/foreach-ondelete-is-not-working-with-lazyvstack/4847
                        Button {
                            self.modalManager.newModal(position: .partiallyRevealed, content: {
                                SheetView(pauses: $pauses)
//                                SheetView(pauses: $pauses, onDisappearFlag: $onDisappearFlag)
                                    .onDisappear(){
                                        self.pauseListVM.fetchAllPauses()
                                        print("desapareceu tela sheet")
//                                        print(self.pauseListVM.pauses)
                                    }
                            })
                        } label : {
                            PauseItem(isButton: true, label: "Adicionar pausa")
                        }
                        
                        ForEach(self.pauseListVM.pauses.indices, id: \.self ) { idx in
                            Button {
                                selectedPause = self.pauseListVM.pauses[idx]
                                self.showSheet = true
                            } label: {
                                PauseItem(label: self.pauseListVM.pauses[idx].name)
                            }
                        }
//                        .onDelete(perform: delete)
                    }
                    
                }
                Spacer()
            }
            .sheet(isPresented: $showSheet, content: {
//                TimerView(pause: $selectedPause)
            })
            
            ModalAnchorView()
            
        }.onAppear(perform: {
            self.pauseListVM.fetchAllPauses()
            print("Rolou o onAppear")
        })
    }

//    func delete(at offsets: IndexSet) {
//        for index in offsets {
//        self.pauseListVM.removePause(at: index)
//    }
//        self.pauseListVM.fetchAllPauses()
//    }

//    func OnAppear(_ animated: Bool) {
//        super.viewWillAppear()
//        //Your Code Here...
//    }
    
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
