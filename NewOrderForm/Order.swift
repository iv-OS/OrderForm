//
//  Order.swift
//  NewOrderForm
//
//  Created by Ivo Radoslavov on 12/17/15.
//  Copyright © 2015 Ivo Radoslavov. All rights reserved.
//

import UIKit

class Order: NSObject, NSCoding {
    //MARK Properties:
    
    var client : String
    var unitPrice : Double
    var quantity : Double
    /*
    var total : Double {
        return unitPrice * quantity
    }
    */
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("orders")
    
    //MARK: Types
    
    struct PropertyKey {
        static let clientKey = "client"
        static let unitPriceKey = "unitPrice"
        static let quantityKey = "quantity"
    }
    
    //MARK Initialization:
    
    init(client: String, unitPrice: Double, quantity: Double) {
        self.client = client
        self.unitPrice = unitPrice
        self.quantity = quantity
        
        super.init()
    }
    
    
    //MARK Methods:
    
    func calculateTotal() -> Double {
        return unitPrice * quantity
    }
    
    //MARK NSCoding:
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(client, forKey: PropertyKey.clientKey)
        aCoder.encodeDouble(unitPrice, forKey: PropertyKey.unitPriceKey)
        aCoder.encodeDouble(quantity, forKey: PropertyKey.quantityKey)
    }
    
    required convenience init? (coder aDecoder: NSCoder){
        let client = aDecoder.decodeObjectForKey(PropertyKey.clientKey) as! String
        let unitPrice = aDecoder.decodeDoubleForKey(PropertyKey.unitPriceKey)
        let quantity = aDecoder.decodeDoubleForKey(PropertyKey.quantityKey)
        
        //must call designated initializer
        self.init(client: client, unitPrice: unitPrice, quantity: quantity)
    }
}
