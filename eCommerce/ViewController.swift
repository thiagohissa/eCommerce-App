//
//  ViewController.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

   let appDelegate = UIApplication.shared.delegate as! AppDelegate
//   let context = appDelegate.persistentContainer.viewContext
   
   
   //MARK: Properties
   @IBOutlet weak var mainCollectionView: UICollectionView!
   var arrayOfItems: [Items] = []
   
   //MARK: Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   
   //MARK: CollectionView Methods
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return arrayOfItems.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell:ViewCell = self.mainCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ViewCell
      let item = self.arrayOfItems[indexPath.row]
      cell.cellImage.image = item.itemImage
      cell.cellLabel.text = "$ \(item.itemPriceTag)"
      cell.favoriteCellButton.tag = indexPath.row
      cell.addToCartButton.tag = indexPath.row
      
      cell.cellView.layer.shadowColor = UIColor.black.cgColor
      cell.cellView.layer.shadowOpacity = 0.4
      cell.cellView.layer.shadowOffset = CGSize.zero
      cell.cellView.layer.shadowRadius = 5
      cell.cellView.layer.shadowPath = UIBezierPath(rect: cell.cellView.bounds).cgPath
      
      return cell
   }
   
   
   @IBAction func addToCartTapped(_ sender: UIButton) {
      let context = appDelegate.persistentContainer.viewContext
      let item = self.arrayOfItems[sender.tag]
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

   @IBAction func favoriteTapped(_ sender: UIButton) {
      let heartFilledImage = UIImage(named: "filledHeart.png")
      let context = appDelegate.persistentContainer.viewContext
      let item = self.arrayOfItems[sender.tag]
      let data = UIImageJPEGRepresentation(item.itemImage, 1)
      
      let itemToSave = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
      itemToSave.setValue(item.itemID, forKey: "itemID")
      itemToSave.setValue(data, forKey: "itemImage")
      itemToSave.setValue(item.itemPriceTag, forKey: "itemPrice")
      itemToSave.setValue(item.itemType, forKey: "itemType")
      do {
         try context.save()
         DispatchQueue.main.async {
            sender.setImage(heartFilledImage, for: .normal)
         }
      } catch {
         print("Error trying to save to Cart")
      }
   }
   
   //MARK: IBActions
   @IBAction func backButtonTapped(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   

   
   



}



class ViewCell: UICollectionViewCell {
   let heartFilledImage = UIImage(named: "filledHeart.png")
   let emptyHeartImage = UIImage(named: "heart.png")
   
   @IBOutlet weak var cellView: UIView!
   @IBOutlet weak var favoriteCellButton: UIButton!
   @IBOutlet weak var cellImage: UIImageView!
   @IBOutlet weak var addToCartButton: UIButton!
   @IBOutlet weak var cellLabel: UILabel!

   

   
}



