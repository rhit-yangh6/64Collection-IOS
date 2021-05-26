//
//  ImageDetailViewController.swift
//  64Collection
//
//  Created by admin on 2021/4/25.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var carImageView: UIImageView!
    var imgUrl: String?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ImageUtils.shared.load(imageView: carImageView, from: imgUrl ?? "")
        carImageView.contentMode = .scaleAspectFit
        carImageView.clipsToBounds = true
    }

}
