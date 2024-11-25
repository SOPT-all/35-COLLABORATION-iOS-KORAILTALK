//
//  SeatSelectionDataSource.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/23/24.
//

import UIKit

class SeatSelectionDataSource {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, SeatItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, SeatItem>
    
    enum SeatItem: Hashable {
        
        case seatRow([Seat])
        case leftWindow
        case rightWindow
        
    }
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    
    private var headerData: [Seat] = []
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        configureDataSource()
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else { return }
        registerCells()
        
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            return self?.configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return self?.configureHeader(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }
    
    private func registerCells() {
        guard let collectionView = collectionView else { return }
        
        collectionView.register(SeatCell.self, forCellWithReuseIdentifier: SeatCell.className)
        collectionView.register(WindowCell.self, forCellWithReuseIdentifier: WindowCell.className)
        
        collectionView.register(
            SeatRowHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SeatRowHeaderView.className
        )
    }
    
    private func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: SeatItem
    ) -> UICollectionViewCell? {
        switch item {
        case .seatRow(let seats):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeatCell.className,
                for: indexPath
            ) as! SeatCell
            cell.configure(with: seats)
            return cell
            
        case .leftWindow:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WindowCell.className,
                for: indexPath
            ) as! WindowCell
            
            return cell
            
        case .rightWindow: 
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WindowCell.className,
                for: indexPath
            ) as! WindowCell
            
            return cell
            
        }
    }
    
    private func configureHeader(
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView? {
        guard kind == UICollectionView.elementKindSectionHeader else { return nil }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SeatRowHeaderView.className,
            for: indexPath
        ) as? SeatRowHeaderView
        
        header?.configure(with: headerData)
        return header
    }
    
    func applySnapshot(seats: [Seat]) {
        var snapshot = Snapshot()
        
        let headerSeats = Array(seats.prefix(4))
        headerData = headerSeats
       
        let remainingSeats = Array(seats.dropFirst(4))
        
        snapshot.appendSections([0])
        
        snapshot.appendItems([.seatRow(headerSeats)], toSection: 0)
        
        for i in stride(from: 0, to: remainingSeats.count, by: 4) {
            let seatRow = Array(remainingSeats[i..<min(i + 4, remainingSeats.count)])
            snapshot.appendItems([.seatRow(seatRow)], toSection: 0)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}
