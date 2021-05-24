//
//  BrandTableViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import UIKit

class BrandTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var brandSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        brandSearchBar.delegate = self
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                target: self,
//                action: #selector(showAddBrandDialog))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
//                target: self,
//                action: #selector(refresh))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }

    @IBAction func refreshTriggered(_ sender: UIRefreshControl) {
        refresh()
    }

    @objc func refresh() {
        BackendService.shared.retrieveBrandsList(searchString: brandSearchBar.text ?? "", changeListener: self.renderData)
        // LeanCloudService.shared.retrieveBrandsList(searchString: brandSearchBar.text ?? "", changeListener: self.tableView.reloadData)
    }

    func renderData() {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BackendService.shared.getBrandsCount()
        // return LeanCloudService.shared.getBrandsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: brandCellIdentifier, for: indexPath) as! BrandCell
        let brandDto = BackendService.shared.getBrandAtIndex(index: indexPath.row)
        // let brandDto = LeanCloudService.shared.getBrandAtIndex(index: indexPath.row)
        cell.brandNameLabel.text = brandDto.name
        cell.brandCountryLabel.text = brandDto.country
        ImageUtils.shared.load(imageView: cell.brandLogoImageView, from: brandDto.imgUrl)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typesSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! TypeTableViewController).brandId = //BrandsManager.shared.getBrandIdAtIndex(index: indexPath.row)
                        // LeanCloudService.shared.getBrandAtIndex(index: indexPath.row).brandId
                        BackendService.shared.getBrandAtIndex(index: indexPath.row).brandId
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

class BrandCell: UITableViewCell {
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandCountryLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
}
