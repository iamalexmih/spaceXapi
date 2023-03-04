//
//  NetworkService.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 03.03.2023.
//

import Foundation
import Moya


class NetworkService {
    
    private let provider = MoyaProvider<ApiService>()
    
    func getListLaunchs(_ page: Int, completion: @escaping (Result<ListLaunch, Error>) -> Void) {
        provider.request(.pastLaunches(page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let launchData = try response.map(ListLaunch.self)
                    DispatchQueue.main.async {
                        completion(.success(launchData))
                    }
                } catch {
                    print("Error Decodable ListLaunch: ", error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error Moya ListLaunch", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    
    func getListMembersCrew(_ idLaunch: String, completion: @escaping (Result<ListMembersCrew, Error>) -> Void) {
        provider.request(.getMembersCrew(idLaunch: idLaunch)) { result in
            switch result {
            case .success(let response):
                do {
                    let crewData = try response.map(ListMembersCrew.self)
                    DispatchQueue.main.async {
                        completion(.success(crewData))
                    }
                } catch {
                    print("Error Decodable ListMembersCrew: ", error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error Moya ListMembersCrew", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
