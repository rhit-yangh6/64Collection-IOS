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
        BackendService.shared.brandTypeList!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: typeCellIdentifier, for: indexPath) as! TypeCell
//        let typeDto = BackendService.shared.getTypeAtIndex(index: indexPath.row)
//        cell.typeNameLabel?.text = typeDto.name
//        cell.typeMakeLabel?.text = String(typeDto.make)
//        cell.typeCategoryImage.image = CategoryIconMap[typeDto.category] as? UIImage ?? UIImage(named: "unclassified")
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