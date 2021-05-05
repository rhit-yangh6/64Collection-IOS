//
//  Constants.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import Foundation
import UIKit

let kClassBrand = "Brand"
let kKeyBrandName = "name"
let kKeyBrandCountry = "country"
let kKeyBrandImgUrl = "imgUrl"

let kClassType = "Type"
let kKeyTypeName = "name"
let kKeyTypeMake = "make"
let kKeyTypeBrandId = "brandId"
let kKeyTypeDiecastBrand = "diecastBrand"
let kKeyTypePhotoUrls = "imgUrls"
let kKeyTypeCategory = "category"

let kClassCategory = "Category"
let kKeyCategoryName = "name"

let brandCellIdentifier = "BrandCell"
let typeCellIdentifier = "TypeCell"

let typesSegueIdentifier = "TypesSegue"
let typeDetailSegueIdentifier = "TypeDetailSegue"

let kKeyObjectId = "objectId"

var CategoryIconMap = [
    "Microcar": UIImage(named: "microcar"),
    "Sedan": UIImage(named: "sedan"),
    "Luxury": UIImage(named: "luxury"),
    "SUV": UIImage(named: "suv"),
    "MPV": UIImage(named: "mpv"),
    "Racing": UIImage(named: "racing"),
    "Exotic": UIImage(named: "exotic"),
    "Wagon": UIImage(named: "wagon"),
    "Van": UIImage(named: "van"),
    "Concept": UIImage(named: "concept"),
    "Cabriolet": UIImage(named: "cabriolet"),
    "Hatchback": UIImage(named: "hatchback"),
    "Limousine": UIImage(named: "limousine"),
    "Pickup": UIImage(named: "pickup"),
    "Unclassified": UIImage(named: "unclassified")
]

class Constants {}
