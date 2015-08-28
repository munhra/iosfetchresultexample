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

    let productDao = ProductsDao()
    
    private lazy var productResultsController:NSFetchedResultsController = {
        
        let moc = self.productDao.managedObjectContext
        let entity = NSEntityDescription.entityForName("Products", inManagedObjectContext: moc)
        
        let request = NSFetchRequest()
        request.entity = entity
        request.sortDescriptors = [NSSortDescriptor(key: "prodDescription", ascending: false)]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        controller.delegate = self
        
        return controller
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productResultsController.performFetch(nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender is UIBarButtonItem {
            println("Add Product Form")
            let productViewController = segue.destinationViewController as? ProductViewController
            productViewController?.product = productDao.createManagedObject() as? Products
        }else{
            println("View product details")
        }
    
    }
    
}

extension ProductListViewController:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        println("controllerWillChangeContent")
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        println("didChangeSection")
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        println("controllerDidChangeContent")
    }

}

extension ProductListViewController:UITableViewDelegate {
    


}

extension ProductListViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("productcell", forIndexPath: indexPath) as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfSections = 1
        if let prodSections = self.productResultsController.sections {
            numberOfSections = prodSections.count
        }
        return numberOfSections
    }
}
