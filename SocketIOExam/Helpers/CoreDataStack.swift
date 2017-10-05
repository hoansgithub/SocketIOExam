//
//  CoreDataStack.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/27/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import CoreData
class CoreDataStack {
    let modelName = "SocketIOExam"
    private lazy var documentDir : URL = {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return url.last!
    }()
    
    private lazy var mom : NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: modelName, withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl!)
        return managedObjectModel!
    }()
    
    private lazy var psc : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let url = documentDir.appendingPathComponent(modelName)
        let options = [NSMigratePersistentStoresAutomaticallyOption : true]
        do {
            //add physical persistent store
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            
        }
        catch {
            print("error adding persistent store")
        }
        return coordinator
    }()
    
    lazy var context : NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        return managedObjectContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
    
    func fetch<T:HManagedObject>(_ type : T.Type ,query:String, params : [Any], sortDesc : [NSSortDescriptor]?, completed : (_ error : Error? , _ results : [T])->()) {
        let fetchRequest : NSFetchRequest<T> = T.getFetchRequest()
        if params.count > 0 {
            fetchRequest.predicate = NSPredicate(format: query, argumentArray: params)
        }
        if let sort = sortDesc {
            fetchRequest.sortDescriptors = sort
        }
        
        do
        {
            let results = try context.fetch(fetchRequest)
            completed(nil, results)
        }catch {
            completed(error, [])
            print("Error: \(error) " +
                "description \(error.localizedDescription)")
        }
    }
    
}
