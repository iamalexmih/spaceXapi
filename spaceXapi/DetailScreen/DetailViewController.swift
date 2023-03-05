//
//  DetailViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 02.03.2023.
//

import UIKit
import Stevia



class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var viewModel: DetailViewModel!
    
    private let scrollView = UIScrollView()
    private let cardView = UIView()
    
    private let contentView = UIView()
    
    private let iconMission = WebImageView()
    private let nameMissionLabel = UILabel()
    private let countFirstStagesSubtitleLabel  = UILabel()
    private let countFirstStagesLabel  = UILabel()
    private let statusMissionSubtitleLabel = UILabel()
    private let statusMissionLabel = UILabel()
    private let detailsMissionLabel = UILabel()
    private let dateSubtitleLabel = UILabel()
    private let dateLabel = UILabel()
    
    private var collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    private let crewTitle = UILabel()
    private let nameCrewLabel = UILabel()
    private let agencyCrewLabel = UILabel()
    private let statusCrewLabel = UILabel()
    private let activiteIndicator = UIActivityIndicatorView()
    
    //TODO: Сделать динамический размер scrollView через scrollView.contentLayoutGuide
//    let contentLayoutGuide = scrollView.contentLayoutGuide
    
    private var contentSize: CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 600)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutScrollView()
        configureCollectionView()
        addSubviewsView()
        setConstraints()
        configureViewAndLabels()
        fetchDataCrew()
        setupTextForSubtitleLabels()
        setupDataLaunchForLabels()
    }
    
    private func fetchDataCrew() {
        viewModel.fetchCrew { [collectionView] in
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
}

// MARK: Configuration Interface Label and View

extension DetailViewController {
    private func setupDataLaunchForLabels() {
        activiteIndicator.startAnimating()
        iconMission.set(imageURL: viewModel.launch.links.patch?.large) { [activiteIndicator] in
           activiteIndicator.stopAnimating()
        }
        nameMissionLabel.text = viewModel.launch.name
        statusMissionLabel.text = viewModel.launch.status
        dateLabel.text = viewModel.launch.dateWithTime
        countFirstStagesLabel.text = viewModel.launch.countFirstStages
        detailsMissionLabel.text = viewModel.launch.details ?? Const.String.notAvailableDescript
    }
    
    private func setupTextForSubtitleLabels() {
        title = Const.String.titleDetailScreen
        statusMissionSubtitleLabel.text = Const.String.statusMissionSubtitle
        dateSubtitleLabel.text = Const.String.dateSubtitle
        countFirstStagesSubtitleLabel.text = Const.String.countFirstStagesSubTitle
        crewTitle.text = Const.String.crewTitle
    }
    
    private func configureViewAndLabels() {
        activiteIndicator.color = .gray
        cardView.layer.cornerRadius = 30
        cardView.backgroundColor = Const.Color.lightGray
        iconMission.contentMode = .scaleAspectFit
        iconMission.layer.cornerRadius = 20
        iconMission.clipsToBounds = true
        nameMissionLabel.font = Const.Font.largeBold
        nameMissionLabel.textAlignment = .center
        statusMissionLabel.font = Const.Font.mediumBold
        dateLabel.font = Const.Font.mediumBold
        countFirstStagesLabel.font = Const.Font.mediumBold
        crewTitle.textAlignment = .center
        detailsMissionLabel.numberOfLines = 0
    }
    
    private func layoutScrollView() {
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsHorizontalScrollIndicator = false
    }
}


// MARK: Layout Views and Labels

extension DetailViewController {
    private func addSubviewsView() {
        view.subviews (scrollView)
        scrollView.fillContainer()
        
        scrollView.subviews {
            iconMission
            cardView
        }
        
        cardView.subviews {
            nameMissionLabel
            countFirstStagesLabel
            statusMissionSubtitleLabel
            statusMissionLabel
            countFirstStagesSubtitleLabel
            dateSubtitleLabel
            dateLabel
            crewTitle
            nameCrewLabel
            agencyCrewLabel
            statusCrewLabel
            collectionView
            detailsMissionLabel
        }
        
        iconMission.subviews {
            activiteIndicator
        }
    }
    
    private func setConstraints() {
        nameMissionLabel.width(100%).height(50).top(0)
        align(horizontally: nameMissionLabel)
        collectionView.width(100%).height(80)
        iconMission.width(240).height(240).top(10).centerHorizontally()
        cardView.width(100%).height(view.frame.height + 600).top(260)
        activiteIndicator.fillContainer()
        
        cardView.layout {
            60
            |-16-statusMissionSubtitleLabel-statusMissionLabel|
            12
            |-16-dateSubtitleLabel-dateLabel|
            12
            |-16-countFirstStagesSubtitleLabel-countFirstStagesLabel|
            24
            |crewTitle.width(100%)|
            4
            |collectionView|
            16
            |-16-detailsMissionLabel-16-|
        }
    }
}


// MARK: Configure Collection View

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 80)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Const.Color.lightGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.launch.crew.isEmpty {
            return 1
        } else {
        return viewModel.listMembersCrew.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCell.cellId, for: indexPath) as! CrewCell
        if viewModel.launch.crew.isEmpty {
            cell.setupEmptyCell()
        } else {
            let descriptionCrew = viewModel.listMembersCrew[indexPath.item]
            cell.setupCell(descriptionCrew)
        }
        return cell
    }
}
