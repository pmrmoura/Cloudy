//
//  PauseViewModel.swift
//  Cloudy
//
//  Created by Juliano Vaz on 24/03/21.
//

import Foundation
import SwiftUI
import Combine

class PauseViewModel {
    var id: UUID
    var name: String
    var image: String
    
    init(id: UUID, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(pause: Pause) {
        self.id = pause.id ?? UUID()
        self.name = pause.name ?? ""
        self.image = pause.image ?? ""
    }
}

