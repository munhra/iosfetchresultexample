//
//  ProductViewController.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/27/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProductViewController:UIViewController {
    

    @IBOutlet weak var prodDescription: UITextField!
    @IBOutlet weak var prodQuantity: UITextField!
    var product:Products?
    let productDao = ProductsDao()

    @IBAction func saveProduct(sender: UIButton) {
        println("save product")
        //product?.prodDescription = prodDescription.text
        //product?.prodQtd = prodQuantity.text.toInt()!
        //product?.prodQtd = "\(prodQuantity.text)"
        //productDao.save()
        saveProduct(prodQuantity.text, prodQtd: prodQuantity.text)
    }
    
    func saveProduct(prodDescription:String, prodQtd:String){
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Products", inManagedObjectContext: managedContext)
        let product = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as? Products
        
        product?.prodDescription = prodDescription
        product?.prodQtd = prodQtd.toInt()!
        
        var error:NSError?
        if !managedContext.save(&error){
            println("Could not save error \(error)")
        }
        
        
        
    }

}