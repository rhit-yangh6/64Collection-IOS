//
//  BackendService.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/5/19.
//

import Foundation
import Alamofire

class BackendService {
    var brandList: [BrandDto]?
    var typeList: [TypeDto]?
    var categoryList: [CategoryDto]?
    
    static let shared = BackendService()
    
    private init () {}
    
    func retrieveBrandsList(searchString:String, changeListener: (() -> Void)?) {
        self.brandList = [BrandDto]()
        AF.request("http://139.196.98.81:8080/64collection/brand/list?keyword=\(searchString)").responseJSON {response in
            switch response.result {
            case .success(let JSON):
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
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }
    
    func retrieveTypesList(searchString: String, brandId: String, changeListener: (() -> Void)?) {
        self.typeList = [TypeDto]()
        AF.request("http://139.196.98.81:8080/64collection/type/brand_list?keyword=\(searchString)&brandId=\(brandId)").responseJSON {response in
            switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                
                for type in response.object(forKey: "data")! as! NSArray {
                    let type = type as! NSDictionary
                    let typeDto = TypeDto(objectId: type["id"]! as! String,
                                          name: type["name"]! as! String,
                                          make: type["make"]! as! Int,
                                          diecastBrand: "", // type["diecastBrand"] as! String,
                                          category: type["category"]! as! String,
                                          imgUrls: type["imgUrls"]! as! [String])
                    self.typeList?.append(typeDto)
                }
                changeListener?()
            
            case .failure(let error):
                print("Request failed with error: \(error)")
                changeListener?()
            }
        }
    }
    
    func getBrandsCount() -> Int {
        return self.brandList?.count ?? 0
    }
    
    func getBrandAtIndex(index: Int) -> BrandDto {
        return (self.brandList?[index])!
    }
    
    func getTypesCount() -> Int {
        return self.typeList?.count ?? 0
    }
    
    func getTypeAtIndex(index: Int) -> TypeDto {
        return (self.typeList?[index])!
    }
    
    func clearCache() {
        self.brandList = []
        self.typeList = []
    }
    
}





