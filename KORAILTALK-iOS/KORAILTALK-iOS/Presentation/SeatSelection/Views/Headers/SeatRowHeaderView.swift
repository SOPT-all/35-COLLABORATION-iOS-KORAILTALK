//
//  SeatRowHeaderView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/20/24.
//

import UIKit

import SnapKit
import Then

final class SeatRowHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let leftWindowView = UIView()
    private let leftWindowLabel = UILabel()
    private let leftAisleLabel = UILabel()
    private let rightAisleLabel = UILabel()
    private let rightWindowLabel = UILabel()
    private let rightWindowView = UIView()
    private let seatRowView = SeatRowView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeatRowHeaderView {
    
    // MARK: - Layout
    
    private func setStyle() {
        [leftWindowLabel, rightWindowLabel].forEach {
            $0.text = "창측"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailGrayscale(.gray600)
        }
        
        [leftAisleLabel, rightAisleLabel].forEach {
            $0.text = "내측"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailGrayscale(.gray600)
        }
        
        [leftWindowView, rightWindowView].forEach {
            $0.backgroundColor = .korailBlue(.blue06)
            $0.makeCornerRadius(cornerRadius: 4)
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(
            leftWindowLabel,
            leftAisleLabel,
            rightAisleLabel,
            rightWindowLabel,
            seatRowView,
            leftWindowView,
            rightWindowView
        )
    }
    
    private func setLayout() {
        leftWindowLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(21)
            $0.height.equalTo(14)
        }
        
        leftAisleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(leftWindowLabel.snp.trailing).offset(35)
            $0.width.equalTo(21)
            $0.height.equalTo(14)
        }
        
        rightWindowLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(32)
            $0.width.equalTo(21)
            $0.height.equalTo(14)
        }
        
        rightAisleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(rightWindowLabel.snp.leading).offset(-35)
        }
        
        leftWindowView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19.5)
            $0.leading.equalToSuperview()
            $0.width.equalTo(8)
            $0.height.equalTo(48)
        }
        
        rightWindowView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19.5)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(8)
            $0.height.equalTo(48)
        }
        
        seatRowView.snp.makeConstraints {
            $0.top.equalTo(leftAisleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(leftWindowView.snp.trailing).offset(10)
            $0.trailing.equalTo(rightWindowView.snp.leading).offset(-10)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - func
    
    func setDelegate(_ delegate: SeatRowViewDelegate?) {
        seatRowView.delegate = delegate
    }
    
    func configure(with seats: [Seat]) {
        let firstFourSeats = Array(seats.prefix(4))
        seatRowView.configure(with: firstFourSeats)
    }
    
    func updateSelection(_ selectedSeatId: Int?) {
        seatRowView.updateButtonStyles(selectedSeatId: selectedSeatId)
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    let fourSeatsArray = Array(Coach.mock.seats.prefix(4))
    let headerView = SeatRowHeaderView()
    headerView.configure(with: fourSeatsArray)
    
    return headerView.toPreview()
}

#endif
