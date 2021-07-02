//
// Created by admin on 2021/7/2.
//

import Foundation

class BrandTypeDto {

    var brandId: String
    var typeId: String
    var typeName: String
    var imgUrls: [String]
    var category: String
    var diecastBrand: String
    var make: Int
    var viewTimes: Int
    var brandName: String
    var iconUrl: String
    var country: String

    public init (brandId: String,
                 brandName: String,
                 iconUrl: String,
                 country: String,
                 typeId: String,
                 typeName: String,
                 imgUrls: [String],
                 category: String,
                 diecastBrand: String,
                 make: Int,
                 viewTimes: Int) {
        self.brandId = brandId
        self.brandName = brandName
        self.iconUrl = iconUrl
        self.country = country
        self.typeId = typeId
        self.typeName = typeName
        self.imgUrls = imgUrls
        self.make = make
        self.viewTimes = viewTimes
        self.diecastBrand = diecastBrand
        self.category = category
    }
}