//
//  HomeViewController.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   //MARK: Properties
   let arrayOfImagesNames:[String] = ["shirt.png","jackets.png","pants.png","shorts.png"]
   let arrayOfColors:[UIColor] = [.init(red: 70/255, green: 203/255, blue: 210/255, alpha: 1),.init(red: 44/255, green: 129/255, blue: 133/255, alpha: 1),.init(red: 65/255, green: 172/255, blue: 133/255, alpha: 1), .init(red: 92/255, green: 200/255, blue: 210/255, alpha: 1)]
   @IBOutlet weak var mainTableView: UITableView!
   
   
   
   //MARK: Life Cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      self.mainTableView.separatorStyle = .none
      self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
      self.automaticallyAdjustsScrollViewInsets = false
   }
   
   
   
   //MARK: TableView Methods
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return arrayOfImagesNames.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell: HomeViewControllerCell = self.mainTableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeViewControllerCell
      cell.cellIcon.image = UIImage(named: arrayOfImagesNames[indexPath.row])
      cell.backgroundColor = arrayOfColors[indexPath.row]
      return cell
   }
   

   
   //MARK: Segue
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let index = self.mainTableView.indexPathForSelectedRow
      
      if index?.row == 0 {
         let vc = segue.destination as! ViewController
         vc.arrayOfItems = Model.shared.createShirtItem()
      }
      else if index?.row == 1 {
         let vc = segue.destination as! ViewController
         vc.arrayOfItems = Model.shared.createSweaterItem()
      }
   }
   
   
}




class HomeViewControllerCell: UITableViewCell {
   @IBOutlet weak var cellIcon: UIImageView!
   
}




