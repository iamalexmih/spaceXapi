//
//  ApiService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation
import Moya


enum ApiService {
    case pastLaunches
}

extension ApiService: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.spacexdata.com/v4/")!
    }

    var path: String {
        switch self {
        case .pastLaunches:
            return "launches"
        }
    }

    var method: Moya.Method {
        switch self {
        case .pastLaunches:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .pastLaunches:
            return .requestParameters(parameters: [
//                "sort": "launch_date_utc",
//                "order": "asc",
                "limit": 2
            ], encoding: URLEncoding.default)
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
