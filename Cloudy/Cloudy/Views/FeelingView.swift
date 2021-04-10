    //
    //  FeelingView.swift
    //  Cloudy
    //
    //  Created by Juliano Vaz on 07/04/21.
    //

    import SwiftUI

    struct FeelingView: View {
        
    @State var showConfirmedFeelingView: Bool = false
    @Environment(\.presentationMode) var presentationMode:  Binding<PresentationMode>
    @Binding var pause: PauseViewModel
    @Binding var selectedFeeling: Int
    @Binding var currentScreen: String
        
        var subviews = [
            UIHostingController(rootView: Subview(imageString: "energizado")),
            UIHostingController(rootView: Subview(imageString: "energizado")), //okay
            UIHostingController(rootView: Subview(imageString: "energizado")) //cansado
        ]
        var titles = ["energizado", "okay", "cansado"]
        
        @State var currentPageIndex = 0
        @State var touchedButton = false
        
        var body: some View {
            VStack(alignment: .center) {
                
                HeaderFeelingView(selectedPause: $pause)
                
                Spacer()
                
                HStack{
                        Button(action: {
                            self.touchedButton = true
                            if self.currentPageIndex+1 == self.subviews.count {
                                self.currentPageIndex = 0
                            } else {
                                self.currentPageIndex += 1
                            }
                        }) {
                            ButtonContent(iconName: "arrowLeft")
                        }
                    
                    VStack{
                        
                        Spacer()
                        
                        PageViewController(currentPageIndex: $currentPageIndex, touchRight: $touchedButton, viewControllers: subviews)
                            .frame(height: UIScreen.main.bounds.height*0.2)


                        
                        Group {
                            Text(titles[currentPageIndex])
                                .font(Font.custom("AvenirNext-Regular", size: 20))
                                .fontWeight(.semibold)
                                .frame(width: 140, height: 45)
                                .foregroundColor(.black)
                                .cornerRadius(32.0)
                        }
                        .padding()
                        
                        Spacer()
                        
                    }
                    
                    Button(action: {
                        self.touchedButton = false
                            if self.currentPageIndex-1 == -1 {
                                self.currentPageIndex = 2
                            } else {
                                self.currentPageIndex -= 1
                            }

                    }) {
                        ButtonContent(iconName: "arrowRight")
                    }
                }
                .padding()
                
                
                Button(
                    action: {
                        self.currentScreen = "ConfirmedFeelingView"
                        self.selectedFeeling =  self.currentPageIndex

                        
                    },
                    label: {
                        Text("OK")
                            .font(Font.custom("AvenirNext-Regular", size: 18))
                            .frame(width: 110, height: 45)
                            .foregroundColor(.black)
                            .background(Image("bg-button"))
                            .cornerRadius(32.0)
                            .padding(.bottom, 70)
                    }
                )        
            }
            .background( //VStack
                Image("bg-clouds")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
        }
    }

    struct ButtonContent: View {
        
         var iconName:String
        
        var body: some View {
            Image(iconName)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 35, height: 35)
                .padding()
        }
    }
    
    
    struct HeaderFeelingView: View {
        
        @Environment(\.presentationMode) var presentationMode
        @State var closeFeelingView: Bool = false
        @Binding var selectedPause: PauseViewModel
    
        
        var body: some View {
            
            VStack{
                
                HStack {
                    
                    Spacer()
                    
                    Button(
                        action: {
                            self.closeFeelingView.toggle()
                            presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Image("bn-close")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width*0.07, height: UIScreen.main.bounds.height*0.07)
                        })
                        .padding(.top, 70)
                    
                }//HStack
                .padding(.trailing, 20)
                
                
                
                Text("\(selectedPause.name)")
                    .font(.custom("AvenirNext-Regular", size:30))
                    .foregroundColor(Color.black) //aqui pode pegar a cor do figma e colocar o nome
                    .padding(.leading, 40)
                    .padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                
                Text("Como você se sente depois desta pausa?")
                    .font(.custom("AvenirNext-Regular", size:17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                
                Spacer()
                
            } //VStack
            .frame(width: UIScreen.main.bounds.width, height: 105, alignment: .leading)
            
                    
        }
        
    }
