//
//  CoreDataStack.swift
//  AnchorPoint2
//
//  Created by AlphaDVLPR on 9/27/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import Foundation
import CoreData

//Creates your MOC

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnchorPoint2")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to Load Persistent Store \(error)")
            }
        })
        return container
    }()
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
