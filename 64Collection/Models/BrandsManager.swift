//
//  BrandsManager.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import Foundation
import LeanCloud

class BrandsManager {
    var _objects: [LCObject]?
    
    static let shared = BrandsManager()
    
    private init () {}
    
    func addNewBrand(brandName: String, brandCountry: String, changeListener: (() -> Void)?) {
        do {
            let brand = LCObject(className: kClassBrand)
            try brand.set(kKeyBrandName, value: brandName)
            try brand.set(kKeyBrandCountry, value: brandCountry)
            _ = brand.save { result in
                switch result {
                case .success:
                    changeListener?()
                    break
                case .failure(error: let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getBrands(changeListener: (() -> Void)?) {
        let query = LCQuery(className: kClassBrand)
        query.whereKey(kKeyBrandName, .ascending)
        query.find { result in
            self._objects = result.objects
            changeListener?()
        }
    }
    
    func deleteBrandWithId(id: String, changeListener: (() -> Void)?) {
        let brand = LCObject(className: kClassBrand, objectId: id)
        _ = brand.delete { result in
            switch result {
            case .success:
                changeListener?()
                break
            case .failure(error: let error):
                print(error)
            }
        }
    }
    
    func getBrandIdAtIndex(index: Int) -> String {
        return self._objects?[index].objectId?.stringValue ?? ""
    }
    
    func getBrandNameAtIndex(index: Int) -> String {
        return self._objects?[index].get(kKeyBrandName)?.stringValue ?? ""
    }
    
    func getBrandCountryAtIndex(index: Int) -> String {
        return self._objects?[index].get(kKeyBrandCountry)?.stringValue ?? ""
    }
    
    func getBrandPhotoUrlAtIndex(index: Int) -> String {
        return self._objects?[index].get(kKeyBrandPhotoUrl)?.stringValue ?? ""
    }
    
    var objectsCount: Int {
        return self._objects?.count ?? 0
    }
}
