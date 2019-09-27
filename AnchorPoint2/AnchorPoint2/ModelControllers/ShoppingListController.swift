//
//  ShoppingListController.swift
//  AnchorPoint2
//
//  Created by AlphaDVLPR on 9/27/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    //MARK: - Singleton
    static let shared = ShoppingListController()
    
    //MARK: - Global Variables
    var fetchedResultsController: NSFetchedResultsController<ShoppingList>
    init() {
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let isComplete = NSSortDescriptor(key: "isComplete", ascending: false)
        
        fetchRequest.sortDescriptors = [isComplete]
        
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("error fetching entries: \(error.localizedDescription)")
            
        }
    }
    
    //MARK: - CRUD
    //Create
    func createShoppingList(name: String) {
        _ = ShoppingList(name: name)
        saveToPersistentStores()
    }
    //Read
    //Update
    //Delete
    func deleteShoppingList(item: ShoppingList) {
        CoreDataStack.context.delete(item)
        saveToPersistentStores()
    }
    //Save
    func saveToPersistentStores() {
        do {
            if CoreDataStack.context.hasChanges {
                try CoreDataStack.context.save()
            }
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n~~~\n \(error)")
        }
    }
    
    //Load
}
