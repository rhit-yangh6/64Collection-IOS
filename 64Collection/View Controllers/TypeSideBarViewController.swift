//
//  TypeSideBarViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/8.
//

import UIKit

class TypeSideBarViewController: UIViewController {
    
    var tableViewController: BrandTypeTableViewController {
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! BrandTypeTableViewController
    }
    
    @IBAction func pressedBackToBrandsButton(_ sender: Any) {
        dismiss(animated: true)
        tableViewController.navigationController?.popViewController(animated: true)
    }
}
