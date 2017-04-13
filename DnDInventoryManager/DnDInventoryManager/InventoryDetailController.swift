//
//  InventoryDetailController.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/12/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class InventoryDetailController: UIViewController {
    
    var character : Character!
    var itemIndex : Int!
    var item : Item!

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        self.itemName.text = item.name
        self.itemText.text = item.text
        self.itemQuantity.text = "Quantity: \(item.quantity)"
        
    }

    @IBAction func minusButtonPressed(_ sender: Any) {
        item.quantity = item.quantity - 1
        update()
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        item.quantity = item.quantity + 1
        update()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        character.inventory[itemIndex].quantity = item.quantity
        CloudKit.shared.saveCharacter(character: self.character) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("that did NOT save...waaah-waaah-WAAAAAAA")
            }
        }
    }

}
