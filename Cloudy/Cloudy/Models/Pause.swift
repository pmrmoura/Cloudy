//
//  Model.swift
//  Cloudy
//
//  Created by Pedro Moura on 11/03/21.
//

import Foundation

struct Pause: Identifiable, Codable {
    var id = UUID()
    var name: String
    var image: String
}
