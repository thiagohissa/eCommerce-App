//
//  FavoritesViewController.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   //MARK: Properties
   var arrayOfFavoriteItems: [Items] = []
   @IBOutlet weak var mainTableView: UITableView!
   var firstLoad: Bool = true
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
   
   
   //MARK: Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      self.mainTableView.separatorStyle = .none
      self.mainTableView.allowsMultipleSelectionDuringEditing = false
      getFavoriteItems()
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      if !firstLoad {
         getFavoriteItems()
      }
      else{
         self.firstLoad = false
      }
   }
   
   //MARK: Fetch Favorites
   func getFavoriteItems(){
      self.arrayOfFavoriteItems.removeAll()
      let context = self.appDelegate.persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
      request.returnsObjectsAsFaults = false
      
      do {
         let results = try context.fetch(request)
         if results.isEmpty {
            let cartImage = UIImage(named: "smiley.png")
            let emptyItem = Items.init(anImage: cartImage!, price: 0, aType: "You have no favorites", itemIDID: 404)
            self.arrayOfFavoriteItems.append(emptyItem)
         }
         else {
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
               self.arrayOfFavoriteItems.append(cartItem)
            }
         }
         DispatchQueue.main.async {
            self.mainTableView.reloadData()
         }
      } catch  {
         print("Error trying to fetch saved items")
      }
   }
   
   
   //MARK: TableView Methods
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.arrayOfFavoriteItems.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: FavoritesCell = self.mainTableView.dequeueReusableCell(withIdentifier: "Cell") as! FavoritesCell
      let item = self.arrayOfFavoriteItems[indexPath.row]
      cell.cellImage.image = item.itemImage
      cell.cellPrice.text = "$ \(item.itemPriceTag)"
      cell.cellType.text = item.itemType
      cell.cellHeart.tag = indexPath.row
      return cell
   }
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      let deleteButton = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
         self.mainTableView.dataSource?.tableView!(self.mainTableView, commit: .delete, forRowAt: indexPath)
         return
      })
      
      deleteButton.backgroundColor = UIColor.init(colorLiteralRed: 178/255, green: 10/255, blue: 58/255, alpha: 1)
      
      return [deleteButton]
   }
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      let context = self.appDelegate.persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
      if let result = try? context.fetch(request) {
         context.delete(result[indexPath.row] as! NSManagedObject)
         self.arrayOfFavoriteItems.remove(at: indexPath.row)
         self.appDelegate.saveContext()
         if self.arrayOfFavoriteItems.isEmpty {
            let cartImage = UIImage(named: "smiley.png")
            let emptyItem = Items.init(anImage: cartImage!, price: 0, aType: "You have no favorites", itemIDID: 404)
            self.arrayOfFavoriteItems.append(emptyItem)
         }
         DispatchQueue.main.async {
            self.mainTableView.reloadData()
         }
      }
   }

   
   
   
   
   //MARK: IBActions
   @IBAction func cellHeartTapped(_ sender: UIButton) {
      let context = appDelegate.persistentContainer.viewContext
      let item = self.arrayOfFavoriteItems[sender.tag]
      let data = UIImageJPEGRepresentation(item.itemImage, 1)
      
      let itemToSave = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
      itemToSave.setValue(item.itemID, forKey: "itemID")
      itemToSave.setValue(data, forKey: "itemImage")
      itemToSave.setValue(item.itemPriceTag, forKey: "itemPrice")
      itemToSave.setValue(item.itemType, forKey: "itemType")
      do {
         try context.save()
         DispatchQueue.main.async {
            sender.setTitle("ADDED", for: .normal)
         }
      } catch {
         print("Error trying to save to Cart")
      }

   }
   
}


class FavoritesCell: UITableViewCell {
   
   @IBOutlet weak var cellImage: UIImageView!
   @IBOutlet weak var cellType: UILabel!
   @IBOutlet weak var cellPrice: UILabel!
   @IBOutlet weak var cellHeart: UIButton!
   
   
   
}
