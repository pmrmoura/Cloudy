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
    
    //MARK: Pause fuctions
    
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
    
    //MARK: CompletedPause functions
    
    
    // get records
    func getCompletedPauses() -> [CompletedPause] {
        var CompletedPauses = [CompletedPause]()
        let bdRequest: NSFetchRequest<CompletedPause> = CompletedPause.fetchRequest()
        
        do {
            CompletedPauses = try self.managedContext.fetch(bdRequest)
        } catch {
            print(error)
        }
        
        return CompletedPauses
    }
    
    // save pause
    func saveCompletedPause(id: UUID, endDate: Date, expectedEndDate: Date, feelingAfterPause: String, startDate: Date) {
        let cp = CompletedPause(context: self.managedContext)
        cp.id = id
        cp.endDate = endDate
        cp.expectedEndDate = expectedEndDate
        cp.feelingAfterPause = feelingAfterPause
        cp.startDate = startDate
        do {
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // remove pause
    func removeCompletedPause(id: UUID) {
        let fetchRequest: NSFetchRequest<CompletedPause> = CompletedPause.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let cps = try self.managedContext.fetch(fetchRequest)
            for cp in cps {
                self.managedContext.delete(cp)
            }
            try self.managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // update pause
    func updatePause(id: UUID, endDate: Date, expectedEndDate: Date, feelingAfterPause: String, startDate: Date) {
        let fetchRequest: NSFetchRequest<CompletedPause> = CompletedPause.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let cp = try self.managedContext.fetch(fetchRequest).first
            cp?.endDate = endDate
            cp?.expectedEndDate = expectedEndDate
            cp?.feelingAfterPause = feelingAfterPause
            cp?.startDate = startDate
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
