//
//  ProductViewController.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import UIKit

class ProductListViewController: UIViewController {
    
    
    let productDao = ProductsDao()

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

extension ProductListViewController:UITableViewDelegate {
    


}

extension ProductListViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("productcell", forIndexPath: indexPath) as! UITableViewCell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


}
