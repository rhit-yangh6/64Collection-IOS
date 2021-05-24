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
    var categoryList: [CategoryDto]?
    var tempBrand: BrandDto?

    static let shared = BackendService()

    private init() {
    }

    func retrieveBrandsList(searchString: String, changeListener: (() -> Void)?) {
        AF.request("http://139.196.98.81:8080/64collection/brand/list?keyword=\(searchString)").responseJSON { response in
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

    func retrieveOneBrand(brandId: String, changeListener: (() -> Void)?) {
        AF.request("http://139.196.98.81:8080/64collection/brand/info?brandId=\(brandId)").responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary

                let brand = response.object(forKey: "data")! as! NSDictionary
                    self.tempBrand = BrandDto(id: brand["id"]! as! String,
                            name: brand["name"]! as! String,
                            imgUrl: brand["iconUrl"]! as! String,
                            country: brand["country"]! as! String)
                changeListener?()
            case .failure(let error):
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }

    func retrieveTypesList(searchString: String, brandId: String, changeListener: (() -> Void)?) {

        AF.request("http://139.196.98.81:8080/64collection/type/brand_list?keyword=\(searchString)&brandId=\(brandId)").responseJSON { response in
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
                            brandId: type["brandId"]! as! String)
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

    func clearCache() {
        brandList = []
        typeList = []
    }

    func getTmpBrand() -> BrandDto {
        tempBrand!
    }

}





