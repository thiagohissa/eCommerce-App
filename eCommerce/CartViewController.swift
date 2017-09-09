//
//  CartViewController.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   //MARK: Properties
   @IBOutlet weak var totalLabel: UILabel!
   @IBOutlet weak var mainTableView: UITableView!
   var arrayOfItemsCart: [Items] = []
   var total: Double = 0.0
   var firstLoad: Bool = true
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
   //MARK: Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      self.mainTableView.separatorStyle = .none
      getCartItems()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      if !firstLoad {
         getCartItems()
      }
      else{
         self.firstLoad = false
      }
   }
   
   
   
   func getCartItems(){
      let context = self.appDelegate.persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
      request.returnsObjectsAsFaults = false
      
      do {
         let results = try context.fetch(request)
         for i in results as! [NSManagedObject] {
            guard let itemID = i.value(forKey: "itemID") as? Int else {
               print("Error location : Fetch itemID")
               return
            }
            guard let itemImage = i.value(forKey: "itemImage") as? NSData else {
               print("Error location : Fetch itemImage")
               return
            }
            guard let itemPrice = i.value(forKey: "itemPrice") as? Double else {
               print("Error location : Fetch itemPrice")
               return
            }
            guard let itemType = i.value(forKey: "itemType") as? String else {
               print("Error location : Fetch itemType")
               return
            }
            let cartItem = Items.init(anImage: UIImage(data: itemImage as Data)!, price: itemPrice, aType: itemType, itemIDID: itemID)
            self.total += cartItem.itemPriceTag
            self.arrayOfItemsCart.append(cartItem)
         }
         DispatchQueue.main.async {
            self.totalLabel.text = "Cart Subtotal: $ \(self.total)"
            self.mainTableView.reloadData()
         }
      } catch  {
         print("Error trying to fetch saved items")
      }
   }
   
   
   @IBAction func checkoutButton(_ sender: UIButton) {
   }
   
   
   
   //MARK: TableView Methods
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.arrayOfItemsCart.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: CartCell = self.mainTableView.dequeueReusableCell(withIdentifier: "Cell") as! CartCell
      let item = self.arrayOfItemsCart[indexPath.row]
      cell.cellImage.image = item.itemImage
      cell.cellItemID.text = "Product ID: \(item.itemID)"
      cell.cellItemPrice.text = "$ \(item.itemPriceTag)"
      cell.cellItemType.text = item.itemType
      return cell
   }
   
   
   
   
}


class CartCell: UITableViewCell {
   @IBOutlet weak var cellImage: UIImageView!
   @IBOutlet weak var cellItemID: UILabel!
   @IBOutlet weak var cellItemPrice: UILabel!
   @IBOutlet weak var cellItemType: UILabel!
   
}
