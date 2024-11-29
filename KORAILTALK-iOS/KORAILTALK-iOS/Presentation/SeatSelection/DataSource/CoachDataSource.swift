//
//  CoachDataSource.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

protocol CoachDataSourceDelegate: AnyObject {
    func popupButtonTapped()
    func coachCellSelected(_ coach: Coach)
}

class CoachDataSource: NSObject {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Int, CaseIterable {
        case routeInfo
        case coach
        case seatInfo
    }
    
    enum Item: Hashable {
        case coach(Coach)
        case dummy1
        case dummy2
    }
    
    weak var delegate: CoachDataSourceDelegate?
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    
    // TODO: - 날짜와 경로 데이터를 받아야함.
    
    init(collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        collectionView.delegate = self
        
        configureDataSource()
    }
    
    private func registerCells() {
        guard let collectionView = collectionView else { return }
        
        // Cells
        collectionView.register(CoachHeaderCell.self, forCellWithReuseIdentifier: CoachHeaderCell.className)
        collectionView.register(CoachCell.self, forCellWithReuseIdentifier: CoachCell.className)
        collectionView.register(SeatInfoCell.self, forCellWithReuseIdentifier: SeatInfoCell.className)
        
        // Header
        collectionView.register(
            SeatRowHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SeatRowHeaderView.className
        )
        
        // background
        collectionView.collectionViewLayout.register(
            CoachBackgroundView.self,
            forDecorationViewOfKind: CoachBackgroundView.className
        )
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else { return }
        registerCells()
        
        self.dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item in
                return self?.configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
            }
        )
    }
    
    private func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: Item
    ) -> UICollectionViewCell? {
        guard let section = dataSource?.snapshot().sectionIdentifiers[indexPath.section] else {
            return nil
        }
        
        switch section {
        case .routeInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CoachHeaderCell.className,
                for: indexPath
            ) as! CoachHeaderCell
            cell.updateDate("2024.11.16 (토)")
            cell.updateRoute(departure: "서울", arrival: "부산")
            return cell
            
        case .coach:
            if case let .coach(coach) = item {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CoachCell.className,
                    for: indexPath
                ) as! CoachCell
                cell.configure(with: coach)
                return cell
            }
            
        case .seatInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeatInfoCell.className,
                for: indexPath
            ) as! SeatInfoCell
            cell.delegate = self
            return cell
        }
        
        return nil
    }
    
    func applySnapshot(using trainData: TrainData?) {
        guard let trainData = trainData else { return }
        
        var snapshot = Snapshot()
        
        snapshot.appendSections([.routeInfo])
        snapshot.appendItems([.dummy1], toSection: .routeInfo)
        
        snapshot.appendSections([.coach, .seatInfo])
        snapshot.appendItems( trainData.coaches.map { Item.coach($0) }, toSection: .coach)
        snapshot.appendItems([.dummy2], toSection: .seatInfo)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

}

extension CoachDataSource: SeatInfoCellDelegate {
    
    func popupButtonTapped() {
        delegate?.popupButtonTapped()
    }
    
}

extension CoachDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section),
              section == .coach,
              let item = dataSource?.itemIdentifier(for: indexPath),
              case let .coach(coach) = item else { return }
        
        delegate?.coachCellSelected(coach)
    }
    
}
