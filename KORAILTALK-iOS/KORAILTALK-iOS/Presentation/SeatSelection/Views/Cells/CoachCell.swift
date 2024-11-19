//
//  CoachCell.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/20/24.
//

import UIKit

import SnapKit

final class CoachCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let coachLabel = UILabel()
    private let roomTypeLabel = UILabel()
    private let seatCountLabel = UILabel()
    
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

extension CoachCell {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundView = UIView().then {
            $0.backgroundColor = .korailBasic(.white)
            $0.makeCornerRadius(cornerRadius: 8)
            $0.makeBorder(width: 1, color: .korailGrayscale(.gray300))
        }
        
        selectedBackgroundView = UIView().then {
            $0.backgroundColor = .korailBlue(.blue06)
            $0.layer.borderWidth = 0
        }
        
        coachLabel.do {
            $0.font = .korailCaption(.caption1sb12)
            $0.textAlignment = .center
        }
        
        roomTypeLabel.do {
            $0.font = .korailCaption(.caption2m12)
            $0.textAlignment = .center
        }
        
        seatCountLabel.do {
            $0.font = .korailBody(.body2m14)
            $0.textAlignment = .center
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(
            coachLabel,
            roomTypeLabel,
            seatCountLabel
        )
    }
    
    private func setLayout() {
        coachLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(38)
            $0.height.equalTo(14)
        }
        
        roomTypeLabel.snp.makeConstraints {
            $0.top.equalTo(coachLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(38)
            $0.height.equalTo(14)
        }
        
        seatCountLabel.snp.makeConstraints {
            $0.top.equalTo(roomTypeLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(38)
            $0.height.equalTo(14)
        }
    }
    
    // MARK: - Func
    
    func configure(with coach: Coach) {
        coachLabel.text = "\(coach.coachId)호차"
        roomTypeLabel.text = "일반실"
        seatCountLabel.text = "\(coach.leftSeats)석"
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    let cell = CoachCell()
    cell.configure(with: Coach.mock)
    
    return cell.toPreview()
        .frame(width: 80, height: 72)
}

#endif
