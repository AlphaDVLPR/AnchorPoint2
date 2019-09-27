//
//  ShoppingList+Convienence.swift
//  AnchorPoint2
//
//  Created by AlphaDVLPR on 9/27/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingList {
    
    convenience init(name: String, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
    }
}
