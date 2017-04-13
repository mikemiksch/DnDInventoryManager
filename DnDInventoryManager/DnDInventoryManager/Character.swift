//
//  Character.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit
import CloudKit

class Character {
    
    var userID = String()
    var campaignID : String?
    var name : String?
    var inventory = [Item]()
    var avatar : UIImage?
    
    init(){
        self.avatar = #imageLiteral(resourceName: "default")
//        self.inventory = []
//        let name = "Chalk"
//        let text = "A piece of chalk"
//        
//        let json = ["name": name, "text": text]
//        
//        if let chalk = Item(json: json) {
//            self.inventory.append((item: chalk, count: 1))
        
    }
}

enum CharacterError : Error {
    case writingImageToData
    case writingDatatoDisc
}

extension Character {
    class func recordFor(character: Character) throws -> CKRecord? {
        if let avatar = character.avatar {
            guard let data = UIImageJPEGRepresentation(avatar, 0.7) else { throw CharacterError.writingImageToData }
        
            do {
                try data.write(to: avatar.path)
                let asset = CKAsset(fileURL: avatar.path)
            
                let characterRecord = CKRecord(recordType: "Character")
                characterRecord.setValue(asset, forKey: "avatar")
                characterRecord.setValue(character.name, forKey: "name")
                characterRecord.setValue(character.userID, forKey: "userID")
                characterRecord.setValue(character.campaignID, forKey: "campaignID")
                var itemRecords = [CKRecord]()
                itemRecords = character.inventory.map { Item.recordFor(item: $0) }
                debugPrint(itemRecords)
                
                characterRecord.setValue(itemRecords, forKey: "inventory")
                
                return characterRecord
                
            } catch {
                throw CharacterError.writingDatatoDisc
            }
        } else {
            return nil
        }
    }
}
