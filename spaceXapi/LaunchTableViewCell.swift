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
    
    let label: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        subviews {
            cardView
        }
        
        cardView.subviews {
            label
        }
        
//        cardView.fillContainer()
        cardView.top(10).left(15).right(15).bottom(10).height(220)
        cardView.layer.cornerRadius = 15
        cardView.backgroundColor = .lightGray
        
//        label.fillContainer(padding: 20)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
