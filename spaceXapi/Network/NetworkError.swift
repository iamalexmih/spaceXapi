//
//  NetworkError.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 04.03.2023.
//

import Foundation
import Moya
import Alamofire


enum NetworkError: Error, LocalizedError {
    case badUrl
    case badResponse(statusCode: Int)
    case parsing(DecodingError?)
    case moyaError(MoyaError)
    case imageNotLoaded(AFError)
    
    var description: String {
        switch self {
        case .badUrl: return "Error with URL"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status: \(statusCode)"
        case .parsing(let error):
            return "Parsing error:" + (error?.localizedDescription ?? "")
        case .moyaError(let error):
            return error.localizedDescription
        case .imageNotLoaded(let error):
            return "Image not loaded" + error.localizedDescription
        }
    }
}
