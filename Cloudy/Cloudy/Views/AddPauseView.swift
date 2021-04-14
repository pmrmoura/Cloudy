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
    @State var showSheet: Bool = false
    @State var selectedPause: PauseViewModel = PauseViewModel(id: UUID.init(), name: "Default", image: "01")
    
    var body: some View {
        ZStack {
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Header()
                List {
                    Button (
                        action: {
                            self.modalManager.newModal(position: .partiallyRevealed, content: {
                                SheetView(pauseListVM: self.pauseListVM)
                            })
                        },
                        label: {
                            PauseItem(isButton: true, label: "Adicionar pausa")
                        })
                        .hideRowSeparator()
                    
                    
                    ForEach(self.pauseListVM.pauses.indices, id: \.self ) { idx in
                        Button (
                            action: {
                                selectedPause = self.pauseListVM.pauses[idx]
                                self.showSheet = true
                            },
                            label: {
                                PauseItem(label: self.pauseListVM.pauses[idx].name)
                            })
                            .hideRowSeparator()
                    }
                    .onDelete(perform: delete(at:))
                }
                Spacer()
            }
            .sheet(isPresented: $showSheet, content: {
                TimerView(pause: $selectedPause, selectedFeeling: 0)
            })
            
            ModalAnchorView()
            
        }.onAppear(perform: {
            self.pauseListVM.fetchAllPauses()
            print("Rolou o onAppear")
        })
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
        self.pauseListVM.removePause(at: index)
    }
        self.pauseListVM.fetchAllPauses()
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
    var bgs = ["01","02","03","04"]
    
    var body: some View {
        ZStack {
            Image(bgs[Int.random(in: 0..<3)])
                .resizable()
                .aspectRatio(contentMode: .fill)
            
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

//MARK: Sebosidade so para tirar o separador da List

struct HideRowSeparatorModifier: ViewModifier {
    static let defaultListRowHeight: CGFloat = 44
    var insets: EdgeInsets
    var background: Color
    
    init(insets: EdgeInsets, background: Color) {
        self.insets = insets
        var alpha: CGFloat = 0
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: Self.defaultListRowHeight,
                alignment: .leading
            )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
}

extension EdgeInsets {
    static let defaultListRowInsets = Self(top: 0, leading: UIScreen.main.bounds.width*0.09, bottom: UIScreen.main.bounds.width*0.03, trailing: 0)
}

extension View {
    func hideRowSeparator(insets: EdgeInsets = .defaultListRowInsets, background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}
// fim Sebosidade
