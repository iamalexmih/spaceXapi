//
//  CrewCell.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 02.03.2023.
//

import UIKit
import Stevia


class CrewCell: UICollectionViewCell {
    
    static let cellId = "CrewCell"
    
    private let nameCrewLabel = UILabel()
    private let agencyCrewLabel = UILabel()
    private let statusCrewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = Const.Color.darkGray?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ descriptionCrew: CrewModel) {
        nameCrewLabel.text = descriptionCrew.nameMember
        nameCrewLabel.font = Const.Font.mediumBold
        agencyCrewLabel.text = Const.String.agencySubTitle + descriptionCrew.agencyMember
        statusCrewLabel.text = Const.String.statusSubTitle + descriptionCrew.statusMember
    }
    
    func setupEmptyCell() {
        nameCrewLabel.numberOfLines = 0
        nameCrewLabel.textAlignment = .center
        nameCrewLabel.text = Const.String.notAvailableCrew
        agencyCrewLabel.isHidden = true
        statusCrewLabel.isHidden = true
    }
    
    private func addSubviews() {
        contentView.subviews {
            nameCrewLabel
            agencyCrewLabel
            statusCrewLabel
        }
        contentView.layout {
            4
            |-16-nameCrewLabel-16-|
            6
            |-16-agencyCrewLabel-16-|
            6
            |-16-statusCrewLabel-16-|
            4
        }
    }
}
