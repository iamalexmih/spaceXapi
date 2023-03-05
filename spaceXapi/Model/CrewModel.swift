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
    
    var nameMember: String {
        guard let name = name else { return Const.String.notAvailable}
        return name
    }
    
    var agencyMember: String {
        guard let agency = agency else { return Const.String.notAvailable}
        return agency
    }
    
    var statusMember: String {
        guard let status = status else { return Const.String.notAvailable}
        return status
    }
}
