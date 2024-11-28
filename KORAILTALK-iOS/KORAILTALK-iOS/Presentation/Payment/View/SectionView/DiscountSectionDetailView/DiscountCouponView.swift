//
//  DiscountCouponView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class DiscountCouponView: UIView {

    //MARK: - UI Properties
    
    private let applyCouponButton = KorailDropDownButton(dropDownType: .enableForDiscount, titleText: "할인쿠폰 적용")
    var veteranDiscountButton = KorailDropDownButton(dropDownType: .enableForDiscount, titleText: "국가유공자 할인")
    private let veteranGuardianDiscountButton = KorailDropDownButton(dropDownType: .disable, titleText: "국가유공자 보호자")
    private let severeGuardianDiscountButton = KorailDropDownButton(dropDownType: .disable, titleText: "중증 보호자 할인")
    private let activeDutySoldierDiscountButton = KorailDropDownButton(dropDownType: .enableForDiscount, titleText: "헌역병 할인")
    private let buttonStackView = UIStackView()
    private let descriptionLabel = UILabel()

    // MARK: - Life Cycle
    
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

extension DiscountCouponView {
    
    // MARK: - Layout
    
    private func setStyle() {
        buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
            $0.distribution = .fillEqually
        }
        
        descriptionLabel.do {
            $0.text = "추가로 할인 가능한 항목이 있으신 경우 할인을 적용해주세요/\n추가할인은 어른/청소년 기준, 예매한 매수만큼 적용할 수 있습니다.\n\n경증: 장애의 정도가 심하지 않은 장애인(구 4-6급)\n중증: 장애의 정도가 심한 장애인(구 1-3급)"
            $0.numberOfLines = 0
            $0.font = .korailCaption(.caption4m10)
            $0.textColor = .korailGrayscale(.gray500)
            $0.textAlignment = .left
        }
    }
    
    private func setHierarchy() {
        addSubviews(buttonStackView, descriptionLabel)
        buttonStackView.addArrangedSubviews(
            applyCouponButton,
            veteranDiscountButton,
            veteranGuardianDiscountButton,
            severeGuardianDiscountButton,
            activeDutySoldierDiscountButton
        )
    }
    
    private func setLayout() {
        buttonStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(216)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(12)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Func
    
    func applyVeteranDiscount(_ bool: Bool) {
        veteranDiscountButton.changeOptionLabelState(isHidden: !bool, text: "500원 할인")
    }
}
