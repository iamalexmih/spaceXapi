//
//  ApiService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation
import Moya


enum ApiService {
    case pastLaunches(page: Int)
}

extension ApiService: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.spacexdata.com/v4/")!
    }

    var path: String {
        switch self {
        case .pastLaunches:
            return "launches/query"
        }
    }

    var method: Moya.Method {
        switch self {
        case .pastLaunches:
            return .post
        }
    }
    

    var task: Task {
        switch self {
        case .pastLaunches(let page):
            
            let dateFilter = ["$gte": "2021-01-01T00:00:00.000Z"]
            let query = ["date_utc": dateFilter]
            let options: [String : Any] = [
                "page": page,
                "sort": "desc"
            ]
            
            let parameters: [String : Any]  = [
                "query": query,
                "options": options
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return [
            "Content-type": "application/json"
        ]
    }
}
