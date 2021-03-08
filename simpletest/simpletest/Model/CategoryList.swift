//
//  CategoryList.swift
//  simpletest
//
//  Created by prince on 2021/1/22.
//

import Foundation

struct CategoryList: Codable {
    
    let data: Data
}

struct Data: Codable {
    
    let shopCategoryList: ShopCategoryList
}

struct ShopCategoryList: Codable {
    
    let count: Int
    
    let categoryList: [CategoryListElement]
}

struct CategoryListElement: Codable {
    
    let id: Int
    
    let name: String
}
