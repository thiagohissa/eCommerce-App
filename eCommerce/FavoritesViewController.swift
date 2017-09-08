//
//  FavoritesViewController.swift
//  eCommerce
//
//  Created by Thiago Hissa on 2017-09-08.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
