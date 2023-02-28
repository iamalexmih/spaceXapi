//
//  LaunchModel.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 28.02.2023.
//

import Foundation


struct LaunchModel: Decodable {

    let success: Bool?
    let name: String?
    let cores: [CoresFlight]
    let id: String?
    let date_utc: String?

}


struct CoresFlight: Decodable {
    let flight: Int?
}
