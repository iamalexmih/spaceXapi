//
//  LaunchTableViewCell.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 01.03.2023.
//

import UIKit
import Stevia


class LaunchTableViewCell: UITableViewCell {

    static let cellId = "cell"
    
    let cardView = UIView()
    let iconMission = UIImageView() // links.patch.small
    let nameLabel = UILabel() // (name)
    let dateLabel = UILabel() // формат даты ДД-ММ-ГГГГ
    let statusMissionLabel = UILabel()
    let countFirstStagesLabel  = UILabel() // cores.flight
    let stackLabels = UIView()
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutViews()
        configCardView()
        
        iconMission.backgroundColor = .gray
        iconMission.layer.cornerRadius = 15
        
        configDateLabel()
        exampleTextForLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configDateLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
        dateLabel.text = "01.03.2023"
    }
    
    private func configCardView() {
        cardView.layer.cornerRadius = 15
        cardView.backgroundColor = UIColor(named: "cardViewBG")
    }
    
    private func exampleTextForLabels() {
        statusMissionLabel.text = "status: Succes"
        nameLabel.text = "KoreaSat 5A"
        countFirstStagesLabel.text = "count First Stages: 5"
    }
}



// MARK: Layout Views and Labels

extension LaunchTableViewCell {
    
    private func layoutViews() {
        contentView.subviews { cardView }
        
        stackLabels.subviews {
            nameLabel
            statusMissionLabel
            countFirstStagesLabel
        }
        
        cardView.subviews {
            iconMission
            dateLabel
            stackLabels
        }
        
        stackLabels.layout {
            16
            |nameLabel|
            8
            |statusMissionLabel|
            8
            |countFirstStagesLabel|
            16
        }
        
        cardView.top(10).left(16).right(16).bottom(10).height(200)
        
        cardView.layout {
            16
            |-16-iconMission.size(140)-16-stackLabels.centerVertically()-16-|
            16
            |-16-dateLabel.fillHorizontally()-16-|
            16
        }
    }
}
