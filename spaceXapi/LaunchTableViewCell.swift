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
    let iconMission = WebImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let statusMissionLabel = UILabel()
    let countFirstStagesLabel  = UILabel()
    let stackLabels = UIView()
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutViews()
        configCardView()
        configIconMission()
        configNameLabel()
        configDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(descriptionLaunch: ListLaunch) {
        // TODO: перенести логику Статус Миссии success в модель для парсинга.
        statusMissionLabel.text = "status: \(String(describing: descriptionLaunch.success?.description ?? "N/A"))"
        nameLabel.text = "\(descriptionLaunch.name ?? "N/A")"
        countFirstStagesLabel.text = "count first stages: \(descriptionLaunch.cores?.count.description ?? "N/A")"
        
        iconMission.set(imageURL: descriptionLaunch.links.patch?.small)
        
        // сделать Расширения для преобразования даты
        let date = descriptionLaunch.date_utc
        dateLabel.text = date?.convertDate()
        // Сервис для скачивания картинки
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
