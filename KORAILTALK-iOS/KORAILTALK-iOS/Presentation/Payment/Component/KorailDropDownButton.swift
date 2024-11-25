//
//  KorailDiscountCouponButton.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/22/24.
//

import UIKit

import SnapKit
import Then

enum DropDownButtonType {
    case enanbleForDiscount
    case enanbleForSeat
    case disable
}

final class KorailDropDownButton: UIButton {
    
    //MARK: - Properties
    
    private let dropDownButtonType: DropDownButtonType
    private let titleText: String
    private let optionText: String

    //MARK: - UI Properties
    
    private let couponTitleLabel = UILabel()
    private lazy var optionLabel = UILabel()
    private let dropdownImageView = UIImageView()
        
    // MARK: - Life Cycle
    
    init(dropDownType: DropDownButtonType, titleText: String, optionText: String? = nil) {
        self.dropDownButtonType = dropDownType
        self.titleText = titleText
        switch dropDownType {
        case .enanbleForDiscount, .enanbleForSeat:
            self.optionText = optionText ?? ""
        case .disable:
            self.optionText = optionText ?? "적용대상 없음"
        }
        
        super.init(frame: .zero)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KorailDropDownButton {
    
    // MARK: - Layout
    
    private func setStyle() {
        makeCornerRadius(cornerRadius: 8)
        isEnabled = dropDownButtonType == .disable ? false : true
        
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
            $0.text = optionText

            switch dropDownButtonType {
            case .enanbleForDiscount:
                $0.font = .korailCaption(.caption2m12)
                $0.textColor = .korailPurple(.purple03)
                $0.isHidden = true
            case .enanbleForSeat:
                $0.font = .korailBody(.body2m14)
                $0.textColor = .korailBlue(.blue01)
                $0.isHidden = false
            case .disable:
                $0.font = .korailCaption(.caption2m12)
                $0.textColor = .korailGrayscale(.gray500)
                $0.isHidden = false
            }

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
