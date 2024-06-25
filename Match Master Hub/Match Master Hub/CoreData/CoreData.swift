//
//  CoreData.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI
import CoreData

class CoreDatas {
    
    static let shared = CoreDatas()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
