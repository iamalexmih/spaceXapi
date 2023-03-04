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
    
    func setupCell(descriptionLaunch: Launch) {
        // TODO: перенести логику Статус Миссии success в модель для парсинга.
        statusMissionLabel.text = "status: \(descriptionLaunch.success?.description ?? "N/A")"
        nameLabel.text = "\(descriptionLaunch.name ?? "N/A")"
        countFirstStagesLabel.text = "count first stages: \(descriptionLaunch.cores?.count.description ?? "N/A")"
        
        // Активити индикатор Старт
        iconMission.set(imageURL: descriptionLaunch.links.patch?.small) {
            //TODO: Активити индикатор стоп
        }
        
        //TODO: Сделать чтоб дата форматировалась в Модели
        let date = descriptionLaunch.date_utc
        dateLabel.text = date?.convertDate()
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
    }
    
    private func setConstraintStackLabels() {
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
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private func configDateLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    private func configCardView() {
        cardView.layer.cornerRadius = 15
        cardView.backgroundColor = UIColor(named: "cardViewBG")
    }
    
    private func configIconMission() {
        iconMission.layer.cornerRadius = 50
        iconMission.clipsToBounds = true
        iconMission.contentMode = .scaleAspectFit
    }
}
