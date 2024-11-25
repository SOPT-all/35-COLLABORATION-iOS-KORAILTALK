//
//  SeatInfoCell.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

import SnapKit
import Then

protocol SeatInfoCellDelegate: AnyObject {
    func popupButtonTapped()
}

final class SeatInfoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: SeatInfoCellDelegate?
    
    // MARK: - UI Properties
    
    private let seatForwardLabel = UILabel()
    private let seatReverseLabel = UILabel()
    private let seatUnavailableLabel = UILabel()
    private let popupButton = UIButton()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeatInfoCell {
    
    // MARK: - Layout
    
    private func setStyle() {
        seatForwardLabel.do {
            $0.configureWithImage(
                text: "선택가능 (순방향)",
                font: .korailCaption(.caption2m12),
                textColor: .korailGrayscale(.gray600),
                image: .icnSeatForward.withRenderingMode(.alwaysOriginal)
            )
        }
        
        seatReverseLabel.do {
            $0.configureWithImage(
                text: "선택가능 (순방향)",
                font: .korailCaption(.caption2m12),
                textColor: .korailGrayscale(.gray600),
                image: .icnSeatBackward.withRenderingMode(.alwaysOriginal)
            )
        }
        
        seatUnavailableLabel.do {
            $0.configureWithImage(
                text: "선택불가",
                font: .korailCaption(.caption2m12),
                textColor: .korailGrayscale(.gray600),
                image: .rectangle171.withRenderingMode(.alwaysOriginal)
            )
        }
        
        popupButton.do {
            var config = UIButton.Configuration.filled()
            config.attributedTitle = NSAttributedString.makeAttributedString(
                text: "콘센트 확인",
                color: .korailBlue(.blue01),
                font: .korailCaption(.caption1sb12)
            )
            config.image = .icnSeatMapOutlet.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 4
            config.baseBackgroundColor = .korailBasic(.white)
            config.cornerStyle = .capsule

            config.background.strokeWidth = 1
            config.background.strokeColor = .korailGrayscale(.gray200)
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 12)
            
            $0.configuration = config
            $0.contentHorizontalAlignment = .leading
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(
            seatForwardLabel,
            seatReverseLabel,
            seatUnavailableLabel,
            popupButton
        )
    }
    
    private func setLayout() {
        popupButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(95)
            $0.height.equalTo(28)
        }
        
        seatForwardLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        seatReverseLabel.snp.makeConstraints {
            $0.top.equalTo(seatForwardLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
        }
        
        seatUnavailableLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(seatForwardLabel.snp.trailing).offset(12)
        }
    }
    
    private func setAction() {
        let popupButtonTapped = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.popupButtonTapped()
            
        }
        popupButton.addAction(popupButtonTapped, for: .touchUpInside)
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    SeatInfoCell().toPreview()
}

#endif
