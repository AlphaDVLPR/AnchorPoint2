//
//  ShoppingListTableViewController.swift
//  AnchorPoint2
//
//  Created by AlphaDVLPR on 9/27/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController, ShoppingListTableViewCellDelegate {
    func shoppingListIsCompleted(_ sender: ShoppingListTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let item = ShoppingListController.shared.fetchedResultsController.object(at: index)
        item.isComplete.toggle()
        sender.updateViews(shoppingList: item)
    }
    

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingListController.shared.fetchedResultsController.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ShoppingListController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }

        let shoppingListItem = ShoppingListController.shared.fetchedResultsController.object(at: indexPath)
        cell.delegate = self
        cell.updateViews(shoppingList: shoppingListItem)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let index = ShoppingListController.shared.fetchedResultsController.object(at: indexPath)
            ShoppingListController.shared.deleteShoppingList(item: index)
        }
    }
    
    //MARK: - Actions
    @IBAction func addItemButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add an Item", message: "Please Enter a shopping list item", preferredStyle: .alert)
        let isKanyeButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newItem = alert.textFields?[0].text else {return}
            ShoppingListController.shared.createShoppingList(name: newItem)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addTextField { (_) in
        }
        alert.addAction(isKanyeButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
}

//MARK: - Extensions
extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
}
