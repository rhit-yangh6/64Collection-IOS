//
//  CategoryDto.swift
//  64Collection
//
//  Created by Hanyu Yang on 2021/5/5.
//

import Foundation

class CategoryDto {
    
    var objectId: String
    var category: String
    
    public init (id: String, category: String) {
        self.objectId = id
        self.category = category
    }
}
