//
//  Items.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit

class Items: NSObject {
   
   var itemImage: UIImage!
   var itemPriceTag: Double
   var itemType: String!
   var itemID: Int
   
   init(anImage: UIImage, price: Double, aType:String, itemIDID: Int) {
      itemImage = anImage
      itemPriceTag = price
      itemType = aType
      if itemIDID == 0 {
         itemID = Int(arc4random_uniform(99999) + arc4random_uniform(99999))
      }
      else {
         itemID = itemIDID
      }
   }
   
}


class Model: NSObject {
   
   static let shared = Model()
   
   func createShirtItem() -> Array<Items> {
      let shirtImage = UIImage(named: "model_shirt.jpg")
      let shirtImage2 = UIImage(named: "model_shirt2.jpg")
      let shirtImage3 = UIImage(named: "model_shirt3.jpg")
      let shirtItem = Items.init(anImage: shirtImage!, price: 24.99, aType: "Shirt", itemIDID: 0)
      let shirtItem2 = Items.init(anImage: shirtImage2!, price: 24.99, aType: "Shirt", itemIDID: 0)
      let shirtItem3 = Items.init(anImage: shirtImage3!, price: 24.99, aType: "Shirt", itemIDID: 0)
      return [shirtItem,shirtItem2,shirtItem3,shirtItem,shirtItem2]
   }
   
   func createSweaterItem() -> Array<Items> {
      let sweaterImage = UIImage(named: "model_sweater.jpg")
      let sweaterImage2 = UIImage(named: "model_sweater2.jpg")
      let sweaterImage3 = UIImage(named: "model_sweater3.jpg")
      let sweaterItem = Items.init(anImage: sweaterImage!, price: 39.99, aType: "Sweater", itemIDID: 0)
      let sweaterItem2 = Items.init(anImage: sweaterImage2!, price: 39.99, aType: "Sweater", itemIDID: 0)
      let sweaterItem3 = Items.init(anImage: sweaterImage3!, price: 39.99, aType: "Sweater", itemIDID: 0)
      return [sweaterItem,sweaterItem2,sweaterItem3,sweaterItem,sweaterItem2]
   }
   
}


