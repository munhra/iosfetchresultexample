//
//  ProductViewController.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/27/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController:UIViewController {
    

    @IBOutlet weak var prodDescription: UITextField!
    @IBOutlet weak var prodQuantity: UITextField!
    var product:Products?
    let productDao = ProductsDao()

    @IBAction func saveProduct(sender: UIButton) {
        println("save product")
        product?.prodDescription = prodDescription.text
        //product?.prodQtd = prodQuantity.text.toInt()!
        //product?.prodQtd = "\(prodQuantity.text)"
        productDao.save()
    }

}