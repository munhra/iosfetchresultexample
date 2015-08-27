//
//  ProductsDao.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import CoreData

class ProductsDao {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
   
        var modelName = "FetchResultExample"
        let modelURL = NSBundle.mainBundle().URLForResource(modelName, withExtension: "momd")
        let mom = NSManagedObjectModel(contentsOfURL: modelURL!)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let storeURL = (urls[urls.endIndex - 1]).URLByAppendingPathComponent("\(modelName).sqlite")
        let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
        let store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: nil)
        
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = psc
        
        return managedObjectContext
        }()
    
    
    func createManagedObject() -> NSManagedObject {
        let moc = self.managedObjectContext
        return NSEntityDescription.insertNewObjectForEntityForName("Products", inManagedObjectContext: moc) as! NSManagedObject
    }
    
    func deleteManagedObject(object: NSManagedObject) {
        let moc = self.managedObjectContext
        moc.deleteObject(object)
        save()
    }
    
    func managedObjectsForName(name: String, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> [AnyObject]! {
        let moc = self.managedObjectContext
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: moc)
        
        let request = NSFetchRequest()
        request.entity = entity
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        return moc.executeFetchRequest(request, error: nil)
    }
    
    func save() {
        var error: NSError?
        let moc = self.managedObjectContext
        
        if !moc.hasChanges {
            return
        }
        
        if moc.save(&error) {
            return
        }
        
        println("error saving context: \(error?.localizedDescription)\n\(error?.userInfo)")
    }

}
