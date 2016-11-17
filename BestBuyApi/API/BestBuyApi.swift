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
    case products(String)
}

extension BestBuy: TargetType {
    public var baseURL: URL { return URL(string: "https://api.bestbuy.com/v1")! }
    public var path: String {
        switch self {
        case .products(_):
            return "/products(releaseDate>today&categoryPath.id in(cat02001))"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
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
        case .products(_):
            return true
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        case .products(_):
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
//        case .userProfile(let name):
//            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
//        case .userRepositories(_):
//            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
