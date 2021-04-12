//
//  Subview.swift
//  Cloudy
//
//  Created by Juliano Vaz on 07/04/21.
//


import SwiftUI

struct Subview: View {
    
    var imageString: String
    
    var body: some View {
        Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .padding(UIScreen.main.bounds.width*0.1)
    }
}

#if DEBUG
struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "okay")
            .previewDevice("iPhone SE (2nd generation)")
        Subview(imageString: "okay")
            .previewDevice("iPhone 11")
        Subview(imageString: "okay")
            .previewDevice("iPhone 8")
        Subview(imageString: "okay")
            .previewDevice("iPhone 11 Pro")
    }
}
#endif
