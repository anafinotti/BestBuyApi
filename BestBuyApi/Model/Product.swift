//
//  Product.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: Mappable {
    var sku: Int?
    var name: String?
    var image: String?
    var salePrice: Double?
    var customerTopRated: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        sku    <- map["sku"]
        name <- map["name"]
        image <- map["image"]
        salePrice <- map["salePrice"]
        customerTopRated <- map["customerTopRated"]
    }
}
