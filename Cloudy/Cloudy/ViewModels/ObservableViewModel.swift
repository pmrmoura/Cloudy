//
//  ObservableViewModel.swift
//  Cloudy
//
//  Created by Pedro Moura on 23/03/21.
//

import Foundation

/// Generic observable super class fore all ViewModels that uses core data
class ObservableViewModel<T>: ObservableObject {
    @Published var dataSource: [T]
    
    init(dataSource: [T]){
        self.dataSource = dataSource
    }
}
