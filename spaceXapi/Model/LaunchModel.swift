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
    let cores: [CoresFlight]?
    let date_utc: String?
    let links: Patch
    let details: String?
    let crew: [String?]
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
