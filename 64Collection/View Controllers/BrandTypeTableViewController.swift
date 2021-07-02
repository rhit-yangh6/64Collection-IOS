//
//  BrandTypeTableViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import UIKit

class BrandTypeTableViewController: UITableViewController, UISearchBarDelegate {

    var brandId: String!
    @IBOutlet weak var typeSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        typeSearchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                target: self,
                action: #selector(refresh))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    @objc func refresh() {
        BackendService.shared.retrieveTypesListByBrand(searchString: self.typeSearchBar.text ?? "",
                brandId: brandId,
                changeListener: tableView.reloadData)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BackendService.shared.getTypesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: typeCellIdentifier, for: indexPath) as! TypeCell
        let typeDto = BackendService.shared.getTypeAtIndex(index: indexPath.row)
        cell.typeNameLabel?.text = typeDto.name
        cell.typeMakeLabel?.text = String(typeDto.make)
        cell.typeCategoryImage.image = CategoryIconMap[typeDto.category] as? UIImage ?? UIImage(named: "unclassified")
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typeDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! DetailViewController).typeId =
                        BackendService.shared.getTypeAtIndex(index: indexPath.row).objectId
            }
        }
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        refresh()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

class TypeCell: UITableViewCell {
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeMakeLabel: UILabel!
    @IBOutlet weak var typeCategoryImage: UIImageView!
}
