//
//  AddPauseViewModel.swift
//  Cloudy
//
//  Created by Juliano Vaz on 24/03/21.
//

import Foundation
import SwiftUI
import Combine


class AddNewPauseViewModel { //diferencia da List, pois nao é observavel é um obj q vamos add
    
    func savePause(pause: PauseViewModel) {
        DataManager.shared.savePause(id: pause.id, name: pause.name, image: pause.image)
    }
}


