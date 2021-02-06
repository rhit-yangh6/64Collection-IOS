//
//  BrandTableViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import UIKit

class BrandTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddBrandDialog))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
//                                                           target: self,
//                                                           action: #selector(refresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc func refresh() {
        BrandsManager.shared.getBrands(changeListener: self.tableView.reloadData)
    }
    
    @objc func showAddBrandDialog() {
        let alertController = UIAlertController(title: "Create a new Brand",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in textField.placeholder = "Brand Name" }
        alertController.addTextField { (textField) in textField.placeholder = "Brand Country" }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Create Brand", style: .default)
        { (action) in
            let brandTextField = alertController.textFields![0] as UITextField
            let brandCountryTextField = alertController.textFields![1] as UITextField
            BrandsManager.shared.addNewBrand(brandName: brandTextField.text!, brandCountry: brandCountryTextField.text!, changeListener: self.refresh)
        })
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BrandsManager.shared.objectsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: brandCellIdentifier, for: indexPath)
        cell.textLabel?.text = BrandsManager.shared.getBrandNameAtIndex(index: indexPath.row)
        cell.detailTextLabel?.text = BrandsManager.shared.getBrandCountryAtIndex(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // TODO: Auth
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            BrandsManager.shared.deleteBrandWithId(id: BrandsManager.shared.getBrandIdAtIndex(index: indexPath.row), changeListener: refresh)
        }
    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typesSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! TypeTableViewController).brandId = BrandsManager.shared.getBrandIdAtIndex(index: indexPath.row)
            }
        }
    }
}
