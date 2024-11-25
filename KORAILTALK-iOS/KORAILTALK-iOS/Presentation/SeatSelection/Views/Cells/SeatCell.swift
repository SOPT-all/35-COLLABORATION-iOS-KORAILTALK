//
//  SeatCell.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

import SnapKit

class SeatCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let seatRowView = SeatRowView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeatCell {
    
    // MARK: - Layout
    
    private func setHierarchy() {
        self.addSubview(seatRowView)
    }
    
    private func setLayout() {
        seatRowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func configure(with seat: [Seat]) {
        seatRowView.configure(with: seat)
    }
    
}
