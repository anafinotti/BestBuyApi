//
//  BestBuyApi.swift
//  BestBuyApi
//
//  Created by Ana Finotti on 11/17/16.
//  Copyright © 2016 Ana Finotti. All rights reserved.
//

import UIKit
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let BestBuyProvider = MoyaProvider<BestBuy>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum BestBuy {
    case categories(String)
    case products(String)
}

extension BestBuy: TargetType {
    public var baseURL: URL { return URL(string: "https://api.bestbuy.com/v1")! }
    public var path: String {
        switch self {
        case .categories(_):
            return "/categories"
        case .products(_):
            return "products(sku in(9157059,6911158,7835032,5998636,8880044, 6140355, 5834015,1805695, 5326164,1725175,4782022))"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
        case .categories(_):
            return ["format": "json", "show": "id,name", "pageSize": "2", "apiKey": "bd6j9ut3parb7csptftw74b5"]
        case .products(_):
            return ["apiKey": "bd6j9ut3parb7csptftw74b5", "format": "json", "pageSize": "10", "show": "sku,name,image,salePrice,customerTopRated", "sort": "bestSellingRank"]
        default:
            return nil
        }
    }
    public var task: Task {
        return .request
    }
    public var validate: Bool {
        switch self {
        case .categories(_):
            return true
        case .products(_):
            return true
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        case .categories(_):
            return ".".data(using: String.Encoding.utf8)!
        case .products(_):
            return ".".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
