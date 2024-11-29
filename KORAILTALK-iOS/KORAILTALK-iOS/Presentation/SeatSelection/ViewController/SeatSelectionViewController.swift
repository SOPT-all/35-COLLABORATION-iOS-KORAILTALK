//
//  SeatSelectionViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

import SnapKit
import Then

final class SeatSelectionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let timetableId: Int
    private let seatSelectionService = SeatSelectionService()
    
    private var coachDataSource: CoachDataSource?
    private var seatSelectionDataSource: SeatSelectionDataSource?
    private var selectedSeatID: Int?
    private var currentCoach: Coach?
    private var selectedSeat: Seat?
    
    // MARK: - UI Properties
    
    private lazy var coachCollectionView: UICollectionView = {
        let layout = createFirstLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var seatCollectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.createSecondLayout()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    private let bottomView = BottomSelectionView()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoachData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        setNavigationBar()
        setStyle()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    init(timetableId: Int) {
        self.timetableId = timetableId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeatSelectionViewController {
    
    // MARK: - Layout
    
    private func setNavigationBar() {
        self.title = "좌석 선택"
        
        self.setCustomBackButton()
        
        let reloadButtonTapped = UIAction { [weak self] _ in
            // TODO: 새로고침
            print("reloadButtonTapped")
        }
        let reloadButton = UIButton(type: .system).then {
            $0.setImage(.icnReload.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(reloadButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let menuButtonTapped = UIAction { [weak self] _ in
            // TODO: 메뉴버튼
            print("menuButtonTapped")
        }
        let menuButton = UIButton(type: .system).then {
            $0.setImage(.icnMenu.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(menuButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let rightStackView = UIStackView(arrangedSubviews: [reloadButton, menuButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: rightStackView)
        navigationItem.rightBarButtonItem = customBarView
        
    }
    
    private func setStyle() {
        self.view.backgroundColor = .white
        
        bottomView.do {
            $0.backgroundColor = .white
            $0.makeCornerRadius(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.layer.addShadow(
                color: UIColor.black,
                alpha: 0.5,
                x: 0,
                y: 2,
                blur: 10,
                spread: 0
            )
            
        }
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            coachCollectionView,
            seatCollectionView,
            bottomView
        )
    }
    
    private func setLayout() {
        coachCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(270)
        }
        
        seatCollectionView.snp.makeConstraints {
            $0.top.equalTo(coachCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(260)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(seatCollectionView.snp.bottom)
        }
        
        
    }
    
    // MARK: - Private Func
    
    private func configureDataSource() {
        coachDataSource = CoachDataSource(collectionView: coachCollectionView)
        seatSelectionDataSource = SeatSelectionDataSource(collectionView: seatCollectionView)
    }
    
    private func setDelegate() {
        coachDataSource?.delegate = self
        seatSelectionDataSource?.delegate = self
        bottomView.delegate = self
    }
    
    private func createFirstLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let self,
                  let section = CoachDataSource.Section(rawValue: section) else { return nil }
            
            switch section {
            case .routeInfo:
                return self.createRouteLayout()
            case .coach:
                return self.createCoachLayout()
            case .seatInfo:
                return self.createSeatInfoLayout()
            }
        }
    }
    
}

// MARK: - CollectionView Layout

extension SeatSelectionViewController {
    
    private func createSecondLayout() -> NSCollectionLayoutSection {
        let seatRowItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(54)
        )
        let seatRowItem = NSCollectionLayoutItem(layoutSize: seatRowItemSize)
        seatRowItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        
        let seatRowGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(54)
        )
        let seatRowGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: seatRowGroupSize,
            subitems: [seatRowItem]
        )
        
        let section = NSCollectionLayoutSection(group: seatRowGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(70)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createRouteLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(113)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(113)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    private func createCoachLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(96),
            heightDimension: .absolute(72)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(0),
            heightDimension: .absolute(72)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: CoachBackgroundView.className)
        section.decorationItems = [backgroundDecoration]
        
        return section
    }
    
    private func createSeatInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(70)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

// MARK: - Delegate

extension SeatSelectionViewController: CoachDataSourceDelegate {
    
    func popupButtonTapped() {
        let popupVC = OutletPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true)
        
    }
    
    func coachCellSelected(_ coach: Coach) {
        self.currentCoach = coach
        seatSelectionDataSource?.applySnapshot(seats: coach.seats)
    }
    
}

extension SeatSelectionViewController: SeatRowViewDelegate {
    func seatButtonTapped(_ seat: Seat) {
        if selectedSeatID == seat.seatId {
            selectedSeatID = nil
            selectedSeat = nil
        } else {
            selectedSeatID = seat.seatId
            selectedSeat = seat
        }
        
        updateAllSeatViews()
    }
    
    private func updateAllSeatViews() {
        seatCollectionView.visibleCells.compactMap { $0 as? SeatCell }
            .forEach { cell in
                cell.updateSelection(selectedSeatID)
            }
        
        if let headerView = seatCollectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(row: 0, section: 0)
        ) as? SeatRowHeaderView {
            headerView.updateSelection(selectedSeatID)
        }
        
        bottomView.updateSelection(selectedSeatID)
    }
    
}

extension SeatSelectionViewController: BottomSelectionViewDelegate {
    
    func completeButtonTapped() {
        guard let selectedSeat = selectedSeat,
              let currentCoach = currentCoach else { return }
        
        let request = SeatSelectionRequestDTO(
            isAuto: false,
            timetableId: timetableId,
            coachId: currentCoach.coachId,
            seatId: selectedSeat.seatId,
            price: 1000
        )
        
        seatSelectionService.selectSeat(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                if let ticketId = response?.data.ticketId {
                    DispatchQueue.main.async {
                        print("UserDefault Save: ID - \(ticketId)")
                        UserDefaultsManager.shared.saveTicketId(ticketId)
                        
                        let trainCheckVC = TrainCheckViewController()
                        self?.navigationController?.pushViewController(trainCheckVC, animated: true)
                    }
                }
            default:
                break
            }
        }
    }
    
}

// MARK: - Network

extension SeatSelectionViewController {
    
    private func fetchCoachData() {
        seatSelectionService.getCoaches(timetableId: timetableId) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.coachDataSource?.applySnapshot(using: response?.data)
                }
            default:
                break
            }
        }
    }
    
}
