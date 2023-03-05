//
//  LaunchModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation

struct ListLaunch: Codable {
    let docs: [Launch]
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
}

struct Launch: Codable {
    let id: String?
    let name: String?
    let success: Bool?
    let cores: [CoresFlight]
    let date_utc: String?
    let links: Patch
    let details: String?
    let crew: [String?]
    
    var dateWithTime: String {
        date_utc?.convertDate(showTime: true) ?? Const.String.notAvailable
    }
    
    var date: String {
        date_utc?.convertDate(showTime: false) ?? Const.String.notAvailable
    }
    
    var status: String {
        guard let success = success else { return Const.String.notAvailable }
        return success ? Const.String.success : Const.String.failure
    }
    
    var countFirstStages: String {
        guard !cores.isEmpty else { return Const.String.notAvailable }
        guard let flight = cores[0].flight else { return Const.String.notAvailable }
        return flight.description
    }
}


struct CoresFlight: Codable {
    let flight: Int?
}


struct Patch: Codable {
    let patch: SizeImage?
}

struct SizeImage: Codable {
    let small: String?
    let large: String?
}
