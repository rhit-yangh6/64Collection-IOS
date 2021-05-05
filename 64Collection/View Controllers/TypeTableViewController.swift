//
//  TypeTableViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import UIKit

class TypeTableViewController: UITableViewController, UISearchBarDelegate {
    
    var brandId: String!
    @IBOutlet weak var typeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeSearchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(preRefresh))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preRefresh()
    }
    
    @objc func preRefresh() {
        LeanCloudService.shared.retrieveCategoryList(changeListener: self.refresh)
    }
    
    @objc func refresh() {
        LeanCloudService.shared.retrieveTypesList(searchString: self.typeSearchBar.text ?? "",
                                                  brandId: self.brandId,
                                                  changeListener: self.tableView.reloadData)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeanCloudService.shared.getTypesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: typeCellIdentifier, for: indexPath) as! TypeCell
        let typeDto = LeanCloudService.shared.getTypeAtIndex(index: indexPath.row)
        cell.typeNameLabel?.text = typeDto.name
        cell.typeMakeLabel?.text = String(typeDto.make)
        cell.typeCategoryImage.image = CategoryIconMap[LeanCloudService.shared.getCategoryById(id: typeDto.category)] as? UIImage ?? UIImage(named: "unclassified")
        print(LeanCloudService.shared.getCategoryById(id: typeDto.category))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            TypesManager.shared.deleteTypeWithId(id: TypesManager.shared.getTypeIdAtIndex(index: indexPath.row), changeListener: refresh)
    //        }
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typeDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! DetailViewController).typeDto = LeanCloudService.shared.getTypeAtIndex(index: indexPath.row)
            }
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { self.refresh() }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

class TypeCell: UITableViewCell {
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeMakeLabel: UILabel!
    @IBOutlet weak var typeCategoryImage: UIImageView!
}
