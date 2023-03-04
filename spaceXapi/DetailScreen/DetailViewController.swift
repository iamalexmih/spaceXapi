//
//  DetailViewController.swift
//  spaceXapi
//
//  Created by Алексей Попроцкий on 02.03.2023.
//

import UIKit
import Stevia



class DetailViewController: UIViewController, UIScrollViewDelegate {
    
//    - дата и время миссии в формате ЧЧ-ММ ДД-ММ-ГГГГ
    var viewModel: DetailViewModel!
    
    private let scrollView = UIScrollView()
    private let cardView = UIView()
    
    private let iconMission = WebImageView()
    private let nameMissionLabel = UILabel()
    private let countFirstStagesSubtitleLabel  = UILabel()
    private let countFirstStagesLabel  = UILabel()
    private let statusMissionSubtitleLabel = UILabel()
    private let statusMissionLabel = UILabel()
    private let detailsMissionLabel = UILabel() // ЧЧ-ММ ДД-ММ-ГГГГ
    private let dateSubtitleLabel = UILabel()
    private let dateLabel = UILabel()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
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
        iconMission.set(imageURL: viewModel.launch.links.patch?.large) {
            self.activiteIndicator.stopAnimating()
        }
        nameMissionLabel.text = viewModel.launch.name
        statusMissionLabel.text = viewModel.launch.success?.description ?? "N/A"
        dateLabel.text = viewModel.launch.date_utc?.convertDate()
        countFirstStagesLabel.text = viewModel.launch.cores?.count.description ?? "N/A"
        detailsMissionLabel.text = viewModel.launch.details ?? "There are no launch descriptions."
    }
    
    private func setupTextForSubtitleLabels() {
        title = "DETAIL LAUNCH"
        statusMissionSubtitleLabel.text = "Status Mission:"
        dateSubtitleLabel.text = "Date Launch:"
        countFirstStagesSubtitleLabel.text = "Count First Stage:"
        crewTitle.text = "Member Crew"
    }
    
    private func configureViewAndLabels() {
        cardView.layer.cornerRadius = 30
        cardView.backgroundColor = UIColor(named: "cardViewBG")
        
        iconMission.contentMode = .scaleAspectFit
        iconMission.layer.cornerRadius = 240 / 2
        iconMission.clipsToBounds = true
        
        nameMissionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameMissionLabel.textAlignment = .center
        
        crewTitle.textAlignment = .center
        detailsMissionLabel.numberOfLines = 0
    }
    
    private func layoutScrollView() {
        scrollView.backgroundColor = .white
//        scrollView.delegate = self
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.contentInsetAdjustmentBehavior = .never
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
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
            detailsMissionLabel
            dateSubtitleLabel
            dateLabel
            crewTitle
            nameCrewLabel
            agencyCrewLabel
            statusCrewLabel
            collectionView
        }
        
        iconMission.subviews {
            activiteIndicator
        }
        activiteIndicator.fillContainer()
    }
    
    private func setConstraints() {
        nameMissionLabel.width(100%).height(50).top(0)
        align(horizontally: nameMissionLabel)
        collectionView.width(100%).height(80)
        iconMission.width(240).height(240).top(0).centerHorizontally()
        cardView.width(100%).height(view.frame.height + 600).top(250)
       
        cardView.layout {
            60
            |-16-statusMissionSubtitleLabel-8-statusMissionLabel|
            12
            |-16-dateSubtitleLabel-8-dateLabel|
            12
            |-16-countFirstStagesSubtitleLabel-8-countFirstStagesLabel|
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
        collectionView.backgroundColor = UIColor(named: "cardViewBG")
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
            cell.setupCell(descriptionCrew: viewModel.listMembersCrew[indexPath.item])
        }
        return cell
    }
}
