//
//  TypeTableViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import UIKit

class TypeTableViewController: UITableViewController {
    
    var brandId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                                                            target: self,
//                                                            action: #selector(showAddTypeDialog))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(refresh))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc func refresh() {
        LeanCloudService.shared.retrieveTypesList(brandId: self.brandId, changeListener: self.tableView.reloadData)
    }
    
//    @objc func showAddTypeDialog() {
//        let alertController = UIAlertController(title: "Create a new Type",
//                                                message: "",
//                                                preferredStyle: .alert)
//
//        alertController.addTextField { (textField) in textField.placeholder = "Type Name" }
//        alertController.addTextField { (textField) in textField.placeholder = "Type Make (Year)" }
//        alertController.addTextField { (textField) in textField.placeholder = "Diecast Brand"}
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alertController.addAction(UIAlertAction(title: "Create Type", style: .default)
//        { (action) in
//            let typeNameTextField = alertController.textFields![0] as UITextField
//            let typeMakeTextField = alertController.textFields![1] as UITextField
//            let typeDiecastBrandTextField = alertController.textFields![2] as UITextField
//            TypesManager.shared.addNewType(typeName: typeNameTextField.text!, typeMake: Int(typeMakeTextField.text!)!, brandId: self.brandId, diecastBrand: typeDiecastBrandTextField.text!, changeListener: self.refresh)
//        })
//        present(alertController, animated: true, completion: nil)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeanCloudService.shared.getTypesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: typeCellIdentifier, for: indexPath)
        let typeDto = LeanCloudService.shared.getTypeAtIndex(index: indexPath.row)
        cell.textLabel?.text = typeDto.name
        cell.detailTextLabel?.text = String(typeDto.make)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // TODO: Auth
        return false
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            TypesManager.shared.deleteTypeWithId(id: TypesManager.shared.getTypeIdAtIndex(index: indexPath.row), changeListener: refresh)
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == typeCellIdentifier {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                (segue.destination as! MessageTableViewController).groupId = GroupsManager.shared.getGroupIdWithIndex(index: indexPath.row)
//            }
//        }
    }
}

