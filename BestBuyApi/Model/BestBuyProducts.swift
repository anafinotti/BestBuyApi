//
//  BestBuyProducts.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class BestBuyProducts: Mappable {
    var canonicalUrl: String?
    var products: [Product]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        canonicalUrl    <- map["canonicalUrl"]
        products <- map["products"]
    }
}
