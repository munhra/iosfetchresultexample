//
//  FetchControllerDelegate.swift
//  FetchResultExample
//
//  Created by Rafael M. A. da Silva on 8/26/15.
//  Copyright (c) 2015 munhra. All rights reserved.
//

import Foundation
import CoreData

class ProductResultFetchControllerDelegate: NSFetchedResultsControllerDelegate {
    
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