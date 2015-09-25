//
//  ProductViewController.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

/*

    useful links

    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableView_Class/index.html#//apple_ref/occ/instm/UITableView/setEditing:animated:
    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewCell_Class/index.html#//apple_ref/doc/uid/TP40006938
    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDelegate_Protocol/#//apple_ref/doc/uid/TP40006942-CH3-SW20
    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDataSource_Protocol/
    https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UITableViewRowAction_class/index.html
    https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewCell_Class/index.html#//apple_ref/doc/uid/TP40006938
*/

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
        self.productResultsController.performFetch(nil)
        self.productTableView.reloadData();
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender is ProductViewCell {
            println("It is a ProductViewCell")
            let productViewCell = sender as? ProductViewCell
            let productViewController = segue.destinationViewController as? ProductViewController
            productViewController?.product = productViewCell?.product
        }
    }
    
    @IBAction func saveProductUnwid(segue:UIStoryboardSegue) {
        // this unwind tecnic is used to avoid productviewcontroller to leak
        println("unwind from details ")
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
            var myProduct:Products?
            myProduct = Products()
            self.productTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            println(myProduct?.description)
        case .Move:
            println("Move")
        case .Update:
            println("Update")
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        println("controllerDidChangeContent")
        self.productTableView.endUpdates()
        self.productTableView.reloadData()
    }
    
}

extension ProductListViewController:UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        println("editActionsForRowAtIndexPath")
        return nil;
    }
}

extension ProductListViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println("commitEditingStyle")
        if editingStyle == .Delete {
            if let product:Products = productResultsController.objectAtIndexPath(indexPath) as? Products {
                productDao.deleteManagedObject(product);
            }
        }
    }
    
    // For the delete button to appear autolayout is required ! It take me 1 hours to fix
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        println("editingStyleForRowAtIndexPath")
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // for the productResultsController.objectAtIndexPath(indexPath) to be casted to Product, file FetchResulExample.xcdatamodeld shall 
        // be edited and the class value changed to FetchResultExample.Products, it took me 2 hours to fix
        let cell = tableView.dequeueReusableCellWithIdentifier("productcell", forIndexPath: indexPath) as! ProductViewCell
        
        if let fetchedProduct:Products = (productResultsController.objectAtIndexPath(indexPath) as? Products) {
            cell.textLabel?.text = fetchedProduct.prodDescription
            cell.product = fetchedProduct
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productResultsController.fetchedObjects!.count
    }
}
