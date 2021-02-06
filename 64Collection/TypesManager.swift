//
//  TypesManager.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/2/7.
//

import Foundation
import LeanCloud

class TypesManager {
    var _objects: [LCObject]?
    
    static let shared = TypesManager()
    
    private init() {}
    
    func addNewType(typeName: String, typeMake: Int, brandId: String, diecastBrand: String, changeListener: (() -> Void)?) {
        do {
            let type = LCObject(className: kClassType)
            try type.set(kKeyTypeName, value: typeName)
            try type.set(kKeyTypeMake, value: typeMake)
            try type.set(kKeyTypeBrandId, value: brandId)
            try type.set(kKeyTypeDiecastBrand, value: diecastBrand)
            _ = type.save { result in
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
    
    func getTypes(brandId: String, changeListener: (() -> Void)?) {
        let query = LCQuery(className: kClassType)
        query.whereKey(kKeyTypeBrandId, .equalTo(brandId))
        query.find { result in
            self._objects = result.objects
            self._objects?.sort(by: { (a, b) -> Bool in
                return a.get(kKeyTypeName)?.stringValue ?? "" <= b.get(kKeyTypeName)?.stringValue ?? ""
            })
            changeListener?()
        }
    }
    
    func deleteTypeWithId(id: String, changeListener: (() -> Void)?) {
        let type = LCObject(className: kClassType, objectId: id)
        _ = type.delete { result in
            switch result {
            case .success:
                changeListener?()
                break
            case .failure(error: let error):
                print(error)
            }
        }
    }
    
    func getTypeIdAtIndex(index: Int) -> String {
        return self._objects?[index].objectId?.stringValue ?? ""
    }
    
    func getTypeNameAtIndex(index: Int) -> String {
        return self._objects?[index].get(kKeyTypeName)?.stringValue ?? ""
    }
    
    func getTypeMakeAtIndex(index: Int) -> String {
        return String(self._objects?[index].get(kKeyTypeMake)?.intValue ?? 0)
    }
    
    var objectsCount: Int {
        return self._objects?.count ?? 0
    }
    
}
    
