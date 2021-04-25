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
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                                                            target: self,
//                                                            action: #selector(showAddBrandDialog))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(refresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc func refresh() {
        LeanCloudService.shared.retrieveBrandsList(changeListener: self.tableView.reloadData)
    }
    
//    @objc func showAddBrandDialog() {
//        let alertController = UIAlertController(title: "Create a new Brand",
//                                                message: "",
//                                                preferredStyle: .alert)
//
//        alertController.addTextField { (textField) in textField.placeholder = "Brand Name" }
//        alertController.addTextField { (textField) in textField.placeholder = "Brand Country" }
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alertController.addAction(UIAlertAction(title: "Create Brand", style: .default)
//        { (action) in
//            let brandTextField = alertController.textFields![0] as UITextField
//            let brandCountryTextField = alertController.textFields![1] as UITextField
//            BrandsManager.shared.addNewBrand(brandName: brandTextField.text!, brandCountry: brandCountryTextField.text!, changeListener: self.refresh)
//        })
//        present(alertController, animated: true, completion: nil)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeanCloudService.shared.getBrandsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: brandCellIdentifier, for: indexPath) as! BrandCell
        let brandDto = LeanCloudService.shared.getBrandAtIndex(index: indexPath.row)
        cell.brandNameLabel.text = brandDto.name
        cell.brandCountryLabel.text = brandDto.country
        ImageUtils.shared.load(imageView: cell.brandLogoImageView, from: brandDto.imgUrl)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            BrandsManager.shared.deleteBrandWithId(id: BrandsManager.shared.getBrandIdAtIndex(index: indexPath.row), changeListener: refresh)
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typesSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! TypeTableViewController).brandId = //BrandsManager.shared.getBrandIdAtIndex(index: indexPath.row)
                    LeanCloudService.shared.getBrandAtIndex(index: indexPath.row).brandId
            }
        }
    }
}

class BrandCell: UITableViewCell {
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandCountryLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
}
