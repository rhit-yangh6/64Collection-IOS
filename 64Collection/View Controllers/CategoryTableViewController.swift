//
//  CategoryTableViewController.swift
//  64Collection
//
//  Created by admin on 2021/5/28.
//

import Foundation
import UIKit

class CategoryTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoryIconMap.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCell
        let index = CategoryIconMap.index(CategoryIconMap.startIndex, offsetBy: indexPath.row)
        let category = CategoryIconMap.keys[index]
        cell.categoryLabel.text = category
        cell.categoryImageView.image = CategoryIconMap[category] as? UIImage ?? UIImage(named: "unclassified")
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == typeDetailSegueIdentifier {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                (segue.destination as! DetailViewController).typeDto =
//                        BackendService.shared.getTypeAtIndex(index: indexPath.row)
//            }
//        }
    }
}

class CategoryCell: UITableViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
}
