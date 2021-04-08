//
//  PauseListViewModel.swift
//  Cloudy
//
//  Created by Juliano Vaz on 24/03/21.
//
import Foundation
import SwiftUI
import Combine

class PauseListViewModel: ObservableObject {
    @Published var pauses = [PauseViewModel]()
    
    func fetchAllPauses() {
        self.pauses = DataManager.shared.getPauses().map(PauseViewModel.init)
    }
    
    func updatePause(pause: PauseViewModel) {
        DataManager.shared.updatePause(id: pause.id, name: pause.name, image: pause.image)
    }
    
    func removePause(at index: Int) {
        let p = pauses[index]
        DataManager.shared.removePause(id: p.id)
    }
}
