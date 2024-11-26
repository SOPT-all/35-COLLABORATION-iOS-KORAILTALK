//
//  KorailDiscountCouponButton.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class KorailDiscountCouponButton: UIButton {
    
    //MARK: - Properties
    
    private let titleText: String

    //MARK: - UI Properties
    
    private let couponTitleLabel = UILabel()
    private lazy var optionLabel = UILabel()
    private let dropdownImageView = UIImageView()
        
    // MARK: - Life Cycle
    
    init(isEnabled: Bool, titleText: String) {
        self.titleText = titleText
        
        super.init(frame: .zero)
        
        self.isEnabled = isEnabled
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KorailDiscountCouponButton {
    
    // MARK: - Layout
    
    private func setStyle() {
        makeCornerRadius(cornerRadius: 8)
        
        if isEnabled {
            makeBorder(width: 1, color: .korailGrayscale(.gray200))
            backgroundColor = .korailBasic(.white)
        } else {
            backgroundColor = .korailGrayscale(.gray100)
        }
        
        couponTitleLabel.do {
            $0.text = titleText
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = isEnabled ? .korailBasic(.black) : .korailGrayscale(.gray400)
        }
        
        optionLabel.do {
            $0.text = titleText
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = isEnabled ? .korailPurple(.purple03) : .korailGrayscale(.gray500)
            $0.isHidden = isEnabled
        }
        
        dropdownImageView.do {
            $0.image = isEnabled ? .icnPaymentArrowdownDefault : .icnPaymentArrowdownDisabled
        }
    }
    
    private func setHierarchy() {
        addSubviews(
            couponTitleLabel,
            optionLabel,
            dropdownImageView
        )
    }
    
    private func setLayout() {
        couponTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        optionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        dropdownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(optionLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
