//
//  ShoppingListTableViewCell.swift
//  AnchorPoint2
//
//  Created by AlphaDVLPR on 9/27/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import UIKit

protocol ShoppingListTableViewCellDelegate: class {
    func shoppingListIsCompleted(_ sender: ShoppingListTableViewCell)
}

class ShoppingListTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    //MARK: - Global Variables
    var shoppingListItem: ShoppingList?
    
    weak var delegate: ShoppingListTableViewCellDelegate?
    
    //MARK: - Private Functions
    func updateViews(shoppingList: ShoppingList) {

        itemLabel.text = shoppingList.name
        
        if shoppingList.isComplete == false {
            isCompleteButton.setImage(UIImage(named: "incomplete"), for: .normal)
        } else {
            isCompleteButton.setImage(UIImage(named: "Gladye"), for: .normal)
        }
    }
    
    //MARK: - Actions
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        delegate?.shoppingListIsCompleted(self)
    }
}
