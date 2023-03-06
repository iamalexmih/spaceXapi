//
//  Event.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 06.03.2023.
//

import Foundation

enum Event {
    case startLoading
    case dataLoaded
    case error(NetworkError?)
}
