//
//  LaunchTableViewCell.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 01.03.2023.
//

import UIKit
import Stevia


class LaunchTableViewCell: UITableViewCell {

    static let cellId = "LaunchTableViewCell"
    
    private let cardView = UIView()
    private let iconMission = WebImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusMissionLabel = UILabel()
    private let countFirstStagesLabel  = UILabel()
    private let stackLabels = UIView()
    private let activiteIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setConstraintStackLabels()
        setConstraintCardView()
        configCardView()
        configIconMission()
        configNameLabel()
        configDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ descriptionLaunch: Launch) {
        statusMissionLabel.text = Const.String.statusSubTitle + descriptionLaunch.status
        nameLabel.text = descriptionLaunch.name ?? Const.String.notAvailable
        countFirstStagesLabel.text = Const.String.countFirstStagesSubTitle + descriptionLaunch.countFirstStages
        activiteIndicator.startAnimating()
        iconMission.set(imageURL: descriptionLaunch.links.patch?.small) { [activiteIndicator] in
            activiteIndicator.stopAnimating()
        }
        dateLabel.text = descriptionLaunch.date
    }
}

// MARK: Layout Views and Labels

extension LaunchTableViewCell {
    private func addSubviews() {
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
        
        iconMission.subviews {
            activiteIndicator
        }
    }
    
    private func setConstraintStackLabels() {
        activiteIndicator.fillContainer()
        stackLabels.layout {
            16
            |nameLabel|
            8
            |statusMissionLabel|
            8
            |countFirstStagesLabel|
            16
        }
    }
    
    private func setConstraintCardView() {
        cardView.top(10).left(16).right(16).bottom(10).height(160)
        cardView.layout {
            16
            |-16-iconMission.size(100)-16-stackLabels.centerVertically()-16-|
            16
            |-16-dateLabel.fillHorizontally()-16-|
            16
        }
    }
}

// MARK: Configuration Interface Label and View

extension LaunchTableViewCell {
    private func configNameLabel() {
        nameLabel.font = Const.Font.mediumBold
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.7
        nameLabel.numberOfLines = 2
    }
    
    private func configDateLabel() {
        dateLabel.font = Const.Font.smallBold
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    private func configCardView() {
        cardView.layer.cornerRadius = 15
        cardView.backgroundColor = Const.Color.lightGray
        cardView.layer.shadowOpacity = 0.23
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func configIconMission() {
        iconMission.layer.cornerRadius = 15
        iconMission.clipsToBounds = true
        iconMission.contentMode = .scaleAspectFit
    }
}
