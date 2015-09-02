//
//  ProductsDao.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProductsDao {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
    
        return managedContext
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
    
    func fetchAllManagedObjects(name:String) -> [AnyObject]!{
        let moc = self.managedObjectContext
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: moc)
        let request = NSFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "prodDescription", ascending: false)]
        request.entity = entity
        
        return moc.executeFetchRequest(request, error: nil)
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
