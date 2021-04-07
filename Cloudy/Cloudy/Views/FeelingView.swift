//
//  FeelingView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 07/04/21.
//

//
//  FeelingView.swift
//  App Onboarding
//

import SwiftUI

struct FeelingView: View {
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "energizado")),
        UIHostingController(rootView: Subview(imageString: "okay")),
        UIHostingController(rootView: Subview(imageString: "cansado"))
    ]
    
    var titles = ["energizado", "okay", "cansado"]
    
    var captions =  ["Take your time out and bring awareness into your everyday life", "Meditating helps you dealing with anxiety and other psychic problems", "Regular medidation sessions creates a peaceful inner mind"]
    
    @State var currentPageIndex = 0
    @State var touchedButton = false
    
    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, touchRight: $touchedButton, viewControllers: subviews)
                .frame(height: 600)
            Group {
                Text(titles[currentPageIndex])
                    .font(.title)
                Text(captions[currentPageIndex])
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
            }
            .padding()
            HStack {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                Button(action: {
                    self.touchedButton = true
                    if self.currentPageIndex+1 == self.subviews.count {
                        self.currentPageIndex = 0
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    ButtonContent(iconName: "arrow.right")
                }
                
                Button(action: {
                    self.touchedButton = false
                        if self.currentPageIndex-1 == -1 {
                            self.currentPageIndex = 2
                        } else {
                            self.currentPageIndex -= 1
                        }
//                    }
                      
                }) {
                    ButtonContent(iconName: "arrow.left")
                }
            }
            .padding()
        }
    }
}

struct ButtonContent: View {
    
     var iconName:String
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding()
            .background(Color.orange)
            .cornerRadius(30)
    }
}

#if DEBUG
struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView()
    }
}
#endif
