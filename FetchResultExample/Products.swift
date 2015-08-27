//
//  Products.swift
//  
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//
//

import Foundation
import CoreData

class Products: NSManagedObject {

    @NSManaged var prodId: NSNumber
    @NSManaged var prodDescription: String
    @NSManaged var prodQtd: NSNumber
    @NSManaged var prodPicture: NSData

}
