//
//  Category.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: Mappable {
    var id: String?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name <- map["name"]
    }
}
