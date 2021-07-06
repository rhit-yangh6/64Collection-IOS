//
// Created by admin on 2021/7/2.
//

import Foundation
import UIKit

class CategoryTypeTableViewController: UITableViewController {

    var category: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                target: self,
                action: #selector(refresh))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    @objc func refresh() {
        BackendService.shared.retrieveTypesListByCategory(category: category!, changeListener: tableView.reloadData)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BackendService.shared.getBrandTypesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryTypeCellIdentifier, for: indexPath) as! CategoryTypeCell
        let brandType = BackendService.shared.getBrandTypeAtIndex(index: indexPath.row)
        cell.brandNameLabel.text = brandType.brandName
        cell.typeNameMakeLabel.text = "\(brandType.typeName) - \(brandType.make)"
        ImageUtils.shared.load(imageView: cell.brandImage, from: brandType.iconUrl)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typeDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! DetailViewController).typeId =
                        BackendService.shared.getBrandTypeAtIndex(index: indexPath.row).typeId
            }
        }
    }
}

class CategoryTypeCell: UITableViewCell {
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var typeNameMakeLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
}
