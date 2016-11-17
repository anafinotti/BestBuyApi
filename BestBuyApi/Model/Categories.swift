//
//  Categories.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import ObjectMapper

class Categories: Mappable {
    var categories: [Category]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        categories <- map["categories"]
    }
}
