//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 12/10/2020.
//

import UIKit
import CoreData


final class CoreDataManager {

    private init() {}
    
    static let shared = CoreDataManager()
    
    lazy var persistantContainer: NSPersistentContainer = {
        let persistantContainer = NSPersistentContainer(name: "EventsApp")
        persistantContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistantContainer
    }()
    
    var context: NSManagedObjectContext {
        persistantContainer.viewContext
    }
    
    
    
    func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest =  NSFetchRequest<T>(entityName: "\(T.self)")
            return try context.fetch(fetchRequest)
        } catch {
            print(error)
            return []
        }
    }
    
    func get<T: NSManagedObject> (with id: NSManagedObjectID) -> T? {
        do {
            return try context.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteAll<Object: NSManagedObject>(object: Object.Type) {
        let fetchRequest =  NSFetchRequest<Object>(entityName: "\(object.self)")
        do {
            // Fetch Data
            let objects = try context.fetch(fetchRequest)
            
            // Delete Data
            _ = objects.map({context.delete($0)})
            
            // Save Data
            save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    

}
