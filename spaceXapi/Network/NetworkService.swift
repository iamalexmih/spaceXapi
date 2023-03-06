//
//  NetworkService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation
import Moya

protocol NetworkServiceProtocol: AnyObject {
    func getListLaunchs(_ page: Int,
                        completion: @escaping (Result<ListLaunch, NetworkError>) -> Void)
    func getListMembersCrew(_ idLaunch: String,
                            completion: @escaping (Result<ListMembersCrew, NetworkError>) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    
    private let provider = MoyaProvider<ApiService>()
    
    func getListLaunchs(_ page: Int, completion: @escaping (Result<ListLaunch, NetworkError>) -> Void) {
        provider.request(.pastLaunches(page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let launchData = try response.map(ListLaunch.self)
                    completion(.success(launchData))
                } catch {
                    completion(.failure(NetworkError.parsing(error as? DecodingError)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.moyaError(error)))
            }
        }
    }
    
    
    func getListMembersCrew(_ idLaunch: String, completion: @escaping (Result<ListMembersCrew, NetworkError>) -> Void) {
        provider.request(.getMembersCrew(idLaunch: idLaunch)) { result in
            switch result {
            case .success(let response):
                do {
                    let crewData = try response.map(ListMembersCrew.self)
                    DispatchQueue.main.async {
                        completion(.success(crewData))
                    }
                } catch {
                    completion(.failure(NetworkError.parsing(error as? DecodingError)))
                }
            case .failure(let error):
                completion(.failure(NetworkError.moyaError(error)))
            }
        }
    }
}
