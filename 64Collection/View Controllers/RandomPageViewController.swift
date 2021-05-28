//
//  RandomPageViewController.swift
//  64Collection
//
//  Created by admin on 2021/5/28.
//

import Foundation
import UIKit

class RandomPageViewController: UIViewController {
    
    @IBAction func randomButtonClicked(_ sender: Any) {
        BackendService.shared.retrieveRandomType(changeListener: onRetrieveComplete)
    }

    func onRetrieveComplete() {
        performSegue(withIdentifier: typeDetailSegueIdentifier, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == typeDetailSegueIdentifier {
            (segue.destination as! DetailViewController).typeDto =
                    BackendService.shared.tempType
        }
    }
}
