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
   
   init(anImage: UIImage, price: Double, aType:String) {
      itemImage = anImage
      itemPriceTag = price
      itemType = aType
   }
}


class Model: NSObject {
   
   static let shared = Model()
   
   func createShirtItem() -> Array<Items> {
      let shirtImage = UIImage(named: "model_shirt.jpg")
      let shirtItem = Items.init(anImage: shirtImage!, price: 24.99, aType: "Shirt")
      return [shirtItem,shirtItem,shirtItem,shirtItem,shirtItem]
   }
   
   func createSweaterItem() -> Array<Items> {
      let sweaterImage = UIImage(named: "model_sweater.jpg")
      let sweaterItem = Items.init(anImage: sweaterImage!, price: 39.99, aType: "Sweater")
      return [sweaterItem,sweaterItem,sweaterItem,sweaterItem,sweaterItem]
   }
   
}


