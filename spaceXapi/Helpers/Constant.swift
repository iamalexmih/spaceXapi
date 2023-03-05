//
//  Constant.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 05.03.2023.
//

import UIKit

enum Const {
    enum String {
        static let titleLaunchesScreen = "LAUNCHES"
        static let titleDetailScreen = "DETAIL LAUNCH"
        static let notAvailable = "N/A"
        static let statusSubTitle = "Status: "
        static let countFirstStagesSubTitle = "Count First Stages: "
        static let notAvailableDescript = "There are no launch descriptions."
        
        static let statusMissionSubtitle = "Status Mission: "
        static let dateSubtitle = "Date Launch: "
        static let crewTitle = "Member Crew"
        static let agencySubTitle = "Agency: "
        static let notAvailableCrew = "No information about the Crew"
        
        static let success = "success"
        static let failure = "failure"
        
        enum Alert {
            static let restart = "\nRestart"
            static let actionTitle = "OK"
            static let messageTitle = "Oops"
        }
    }

    enum Image {
        static let placeHolder = UIImage(named: "placeHolder")
    }
    
    enum Color {
        static let lightGray = UIColor(named: "cardViewBG")
        static let darkGray = UIColor(named: "darkGrayColor")
    }
    
    enum Font {
        static let smallBold = UIFont.boldSystemFont(ofSize: 14)
        static let mediumBold = UIFont.boldSystemFont(ofSize: 16)
        static let largeBold = UIFont.boldSystemFont(ofSize: 20)
    }
}


