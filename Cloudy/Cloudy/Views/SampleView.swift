//
//  SampleView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 15/03/21.
//

import SwiftUI

struct SampleView: View {

    @State private var showSheet: Bool = false

    var body: some View {
        VStack{
            
            Text("Tela de cards!")
            
            Text("Tap to go to timerView")
            Button(action: { self.showSheet = true }) {
                Image(systemName: "mappin.and.ellipse")
            }
            .sheet(isPresented: $showSheet) {TimerView()}
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
