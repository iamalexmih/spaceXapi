//
//  LaunchModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation

struct LaunchModel: Codable {
    let docs: [ListLaunch]
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
}

struct ListLaunch: Codable {
    let success: Bool?
    let name: String?
    let cores: [CoresFlight]?
    let id: String?
    let date_utc: String?
    let links: Patch
}


struct CoresFlight: Codable {
    let flight: Int?
}


struct Patch: Codable {
    let patch: SizeImage?
}

struct SizeImage: Codable {
    let small: String?
}
