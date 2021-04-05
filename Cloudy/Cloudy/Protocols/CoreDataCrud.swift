//
//  CRUD.swift
//  Cloudy
//
//  Created by Pedro Moura on 23/03/21.
//

protocol CoreDataCrud {
    func create(name: String)
    
    func update<T>(item: T, newValues: Array<T>)
    
    func delete<T>(item: T)
}
