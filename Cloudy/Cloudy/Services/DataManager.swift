//
//  DataManager.swift
//  Cloudy
//
//  Created by Juliano Vaz on 24/03/21.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    
    static let shared = DataManager(moc: NSManagedObjectContext.current)
    
    var managedContext: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.managedContext = moc
    }
    
    // get records
    func getPauses() -> [Pause] {
        var pauses = [Pause]()
        let bdRequest: NSFetchRequest<Pause> = Pause.fetchRequest()
        
        do {
            pauses = try self.managedContext.fetch(bdRequest)
        } catch {
            print(error)
        }
        
        return pauses
    }
    
    // save pause
    func savePause(id: UUID, name: String, image: String) {
        let b = Pause(context: self.managedContext)
        b.image = image
        b.name = name
        b.id = id
        do {
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // remove pause
    func removePause(id: UUID) {
        let fetchRequest: NSFetchRequest<Pause> = Pause.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let ps = try self.managedContext.fetch(fetchRequest)
            for p in ps {
                self.managedContext.delete(p)
            }
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // update pause
    func updatePause(id: UUID, name: String, image: String) {
        let fetchRequest: NSFetchRequest<Pause> = Pause.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let p = try self.managedContext.fetch(fetchRequest).first
            p?.image = image
            p?.name = name
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
}

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
