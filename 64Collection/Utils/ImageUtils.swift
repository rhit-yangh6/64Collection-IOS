//
//  ImageUtils.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import Foundation
import UIKit
import Kingfisher

class ImageUtils {
    static let shared = ImageUtils()
    
    private init() {}
    
    func load(imageView: UIImageView, from url: String) {
        if let imgUrl = URL(string: url) {
            imageView.kf.setImage(with: imgUrl)
        }
    }
}
