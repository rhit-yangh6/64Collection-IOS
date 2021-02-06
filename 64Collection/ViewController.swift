//
//  ViewController.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/6.
//

import UIKit
import LeanCloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let testObject = LCObject(className: "TestObject")
            try testObject.set("words", value: "Hello world!")
            let result = testObject.save()
            if let error = result.error {
                print(error)
            }
        } catch {
            print(error)
        }
    }


}

