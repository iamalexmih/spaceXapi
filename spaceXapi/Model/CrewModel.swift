//
//  CrewModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 02.03.2023.
//

import Foundation


struct ListMembersCrew: Codable {
    let docs: [CrewModel]
}

struct CrewModel: Codable {
    let id: String?
    let name: String?
    let agency: String?
    let status: String?
}
