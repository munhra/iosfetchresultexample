//
//  ProductViewController.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    let productDao = ProductsDao()
    
    private lazy var productResultsController:NSFetchedResultsController = {
        
        let moc = self.productDao.managedObjectContext
        let entity = NSEntityDescription.entityForName("Products", inManagedObjectContext: moc)
        
        let request = NSFetchRequest()
        request.entity = entity
        request.sortDescriptors = [NSSortDescriptor(key: "prodDescription", ascending: false)]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        controller.performFetch(nil)
        
        return controller
        
        }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let productsCount = productDao.fetchAllManagedObjects("Products")!.count
        println("Stored products \(productsCount)")
        
        var error: NSError?
        self.productResultsController.performFetch(&error)
        
        if error != nil {
            println("Fetch error")
        }
        
        self.productTableView.reloadData();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError?
        self.productResultsController.performFetch(&error)
        
        if error != nil {
            println("Fetch error")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender is UIBarButtonItem {
            println("Add Product Form")
            let productViewController = segue.destinationViewController as? ProductViewController
        }else{
            println("View product details")
        }
        
    }
    
}

extension ProductListViewController:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        println("controllerWillChangeContent")
        self.productTableView.beginUpdates()
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        println("DidChangeObject");
        
        switch type {
            
        case .Insert:
            println("Insert")
            self.productTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        case .Delete:
            println("Delete")
        case .Move:
            println("Move")
        case .Update:
            println("Update")
            
        }
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type{
            
        case .Insert:
            println("Insert section")
        case .Delete:
            println("Delete section")
        default:
            println("default")
            
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        println("controllerDidChangeContent")
        self.productTableView.endUpdates()
        self.productTableView.reloadData()
    }
    
}

extension ProductListViewController:UITableViewDelegate {
    
}

extension ProductListViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("Fetched items \(productResultsController.fetchedObjects!.count)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("productcell", forIndexPath: indexPath) as! UITableViewCell
        
        if let fetchedProduct:Products = (productResultsController.objectAtIndexPath(indexPath) as? Products) {
                cell.textLabel?.text = fetchedProduct.prodDescription
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productResultsController.fetchedObjects!.count
    }
}
