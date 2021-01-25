//
//  ProductInfoForPartOne.swift
//  simpletest
//
//  Created by prince on 2021/1/23.
//

import Foundation

struct SalePageList: Codable {
    
    let data: SalePageListData
}

struct SalePageListData: Codable {
    
    let shopCategory: ShopCategory
}

struct ShopCategory: Codable {
    
    let salePageList: ShopCategorySalePageList
}

struct ShopCategorySalePageList: Codable {
    
    let salePageList: [SalePageListItem]
}

struct SalePageListItem: Codable {
    
    var salePageID: Int?
    
    var title: String?
    
    var price: Int?
    
    var suggestPrice: Int?
    
    var sellingQty: Int?
    
    var sellingStartDateTime: Int?
    
    var isSoldOut: Bool?
    
    var isComingSoon: Bool?

    enum CodingKeys: String, CodingKey {
        
        case salePageID = "salePageId"
        
        case title, price, suggestPrice
    }
}
