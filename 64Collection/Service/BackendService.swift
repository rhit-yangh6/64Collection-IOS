//
//  BackendService.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/5/19.
//

import Foundation
import Alamofire

class BackendService {
    var brandList: [BrandDto]?
    var typeList: [TypeDto]?
    var brandTypeList: [BrandTypeDto]?
    var tempType: TypeDto?
    var tempBrandType: BrandTypeDto?

    static let shared = BackendService()

    private init() {
    }

    func retrieveBrandsList(searchString: String, changeListener: (() -> Void)?) {
        AF.request("\(API_URL)64collection/brand/list?keyword=\(searchString)").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                self.brandList = [BrandDto]()
                let response = JSON as! NSDictionary
                for brand in response.object(forKey: "data")! as! NSArray {
                    let brand = brand as! NSDictionary
                    let brandDto = BrandDto(id: brand["id"]! as! String,
                            name: brand["name"]! as! String,
                            imgUrl: brand["iconUrl"]! as! String,
                            country: brand["country"]! as! String)
                    self.brandList?.append(brandDto)
                }
                changeListener?()
            case .failure(let error):
                self.brandList = [BrandDto]()
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func retrieveOneType(typeId: String, changeListener: (() -> Void)?) {
        AF.request("\(API_URL)64collection/type/info?typeId=\(typeId)").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary

                let brandType = response.object(forKey: "data")! as! NSDictionary
                self.tempBrandType = BrandTypeDto(
                        brandId: brandType["brandId"]! as! String,
                        brandName: brandType["brandName"]! as! String,
                        iconUrl: brandType["iconUrl"]! as! String,
                        country: brandType["country"]! as! String,
                        typeId: brandType["typeId"]! as! String,
                        typeName: brandType["typeName"]! as! String,
                        imgUrls: brandType["imgUrls"]! as! [String],
                        category: brandType["category"]! as! String,
                        diecastBrand: brandType["diecastBrand"] as! String,
                        make: brandType["make"]! as! Int,
                        viewTimes: brandType["viewTimes"]! as! Int)
                changeListener?()
            case .failure(let error):
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func retrieveRandomType(changeListener: (() -> Void)?) {
        AF.request("\(API_URL)64collection/type/random").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary

                let type = response.object(forKey: "data")! as! NSDictionary
                self.tempType = TypeDto(objectId: type["id"]! as! String,
                        name: type["name"]! as! String,
                        make: type["make"]! as! Int,
                        diecastBrand: type["diecastBrand"] as! String,
                        category: type["category"]! as! String,
                        imgUrls: type["imgUrls"]! as! [String],
                        brandId: type["brandId"]! as! String,
                        viewTimes: type["viewTimes"]! as! Int)
                changeListener?()
            case .failure(let error):
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func retrieveTypesListByBrand(searchString: String, brandId: String, changeListener: (() -> Void)?) {

        AF.request("\(API_URL)64collection/type/brand_list?keyword=\(searchString)&brandId=\(brandId)").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                self.typeList = [TypeDto]()
                for type in response.object(forKey: "data")! as! NSArray {
                    let type = type as! NSDictionary
                    let typeDto = TypeDto(objectId: type["id"]! as! String,
                            name: type["name"]! as! String,
                            make: type["make"]! as! Int,
                            diecastBrand: type["diecastBrand"] as! String,
                            category: type["category"]! as! String,
                            imgUrls: type["imgUrls"]! as! [String],
                            brandId: type["brandId"]! as! String,
                            viewTimes: type["viewTimes"]! as! Int)
                    self.typeList?.append(typeDto)
                }
                changeListener?()
            case .failure(let error):
                self.typeList = [TypeDto]()
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func retrieveTypesListByCategory(category: String, changeListener: (() -> Void)?) {
        AF.request("\(API_URL)64collection/type/category_list?category=\(category)").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                self.brandTypeList = [BrandTypeDto]()
                for brandType in response.object(forKey: "data")! as! NSArray {
                    let brandType = brandType as! NSDictionary
                    let brandTypeDto = BrandTypeDto(
                            brandId: brandType["brandId"]! as! String,
                            brandName: brandType["brandName"]! as! String,
                            iconUrl: brandType["iconUrl"]! as! String,
                            country: brandType["country"]! as! String,
                            typeId: brandType["typeId"]! as! String,
                            typeName: brandType["typeName"]! as! String,
                            imgUrls: brandType["imgUrls"]! as! [String],
                            category: brandType["category"]! as! String,
                            diecastBrand: brandType["diecastBrand"] as! String,
                            make: brandType["make"]! as! Int,
                            viewTimes: brandType["viewTimes"]! as! Int)
                    self.brandTypeList?.append(brandTypeDto)
                }
                changeListener?()
            case .failure(let error):
                self.brandTypeList = [BrandTypeDto]()
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func getBrandsCount() -> Int {
        brandList?.count ?? 0
    }

    func getBrandAtIndex(index: Int) -> BrandDto {
        (brandList?[index])!
    }

    func getTypesCount() -> Int {
        typeList?.count ?? 0
    }

    func getTypeAtIndex(index: Int) -> TypeDto {
        (typeList?[index])!
    }

    func getBrandTypesCount() -> Int {
        brandTypeList?.count ?? 0
    }

    func getBrandTypeAtIndex(index: Int) -> BrandTypeDto {
        (brandTypeList?[index])!
    }

    func clearCache() {
        brandList = []
        typeList = []
    }

}





