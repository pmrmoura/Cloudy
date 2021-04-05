//
//  File.swift
//  Cloudy
//
//  Created by Pedro Moura on 23/03/21.
//

import SwiftUI
import CoreData

extension AddPauseView {
    class ViewModel: ObservableViewModel<Pause> {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        init() {
            super.init(dataSource: [Pause]())
        }
    }
}

extension AddPauseView.ViewModel: ViewModelDataSource {
    func initData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Pause.entity().name!)
        
        do {
            let pausesSaved = try context.fetch(fetchRequest) as? [Pause]
            if let pausesSaved = pausesSaved {
                if pausesSaved.count != 0 {
                    self.dataSource = pausesSaved
                }
                else {
                    self.dataSource = []
                }
            }
        }
        catch {
            print("#seFodeu")
        }
    }
    
    func deinitData() {
        //
    }
}

extension AddPauseView.ViewModel: CoreDataCrud {
    func create(name: String) {
        let newPause = Pause(context: self.context)
        newPause.id = UUID()
        newPause.image = "Cloud1"
        newPause.name = name

        do {
            try self.context.save()
            self.initData()
            print("Salvou")
        }
        catch {
            print("Erro ao salvar")
        }
    }
    
    func update<Pause>(item: Pause, newValues: Array<Pause>) {
        //
    }
    
    func delete<Pause>(item: Pause) {
        //
    }
}
