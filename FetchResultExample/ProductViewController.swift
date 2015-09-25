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
    var myProdDescription:String?
    var myProdQtd:String?

    let productDao = ProductsDao()

    @IBAction func saveProduct(sender: UIButton) {
        println("save product")
        product?.prodDescription = myProdDescription!
        product?.prodQtd = prodQuantity.text.toInt()!
        productDao.save()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if product != nil {
            prodDescription.text = product?.prodDescription
            prodQuantity.text = product?.prodQtd.stringValue
            myProdDescription = product?.prodDescription
            myProdQtd = product?.prodQtd.stringValue
        }
    }
    
    deinit{
        println("ProductViewController Deinit")
    }
    
}