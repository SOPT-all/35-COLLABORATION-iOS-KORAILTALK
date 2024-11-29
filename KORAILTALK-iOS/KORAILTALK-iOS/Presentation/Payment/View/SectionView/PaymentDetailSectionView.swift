//
//  PaymentDetailSectionView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/29/24.
//

import UIKit

import SnapKit
import Then

final class PaymentDetailSectionView: UIView {

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let passengerLabel = UILabel()
    private let usageAmountTextLabel = UILabel()
    private let discountAndPointTextLabel = UILabel()
    private let totalPaymentAmountTextLabel = UILabel()
    let usageAmountLabel = UILabel()
    let discountAndPointLabel = UILabel()
    let totalPaymentAmountLabel = UILabel()
    private let titleStackView = UIStackView()
    private let usageAmountStackView = UIStackView()
    private let discountAndPointStackView = UIStackView()
    private let totalPaymentAmountStackView = UIStackView()
    private let deviderView = UIView()

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

extension PaymentDetailSectionView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.text = "결제수단 선택"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title1sb18)
        }
        
        passengerLabel.do {
            $0.text = "어른 1명 -1매"
            $0.textColor = .korailPurple(.purple02)
            $0.textAlignment = .center
            $0.font = .korailBody(.body2m14)
        }
        
        usageAmountTextLabel.do {
            $0.text = "이용금액"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailBody(.body2m14)
        }
        
        discountAndPointTextLabel.do {
            $0.text = "할인 및 포인트"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailBody(.body2m14)
        }
        
        totalPaymentAmountTextLabel.do {
            $0.text = "총 결제 금액"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title3m16)
        }
        
        usageAmountLabel.do {
            $0.text = "12,500원"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title3m16)
        }
        
        discountAndPointLabel.do {
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title3m16)
        }
        
        totalPaymentAmountLabel.do {
            $0.text = "12,000원"
            $0.textColor = .korailPurple(.purple04)
            $0.textAlignment = .center
            $0.font = .korailHead(.head5m20)
        }
        
        [titleStackView, usageAmountStackView, discountAndPointStackView, totalPaymentAmountStackView].forEach { stackView in
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
        }
        
        deviderView.do {
            $0.backgroundColor = .korailGrayscale(.gray200)
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleStackView,
                    usageAmountStackView,
                    discountAndPointStackView,
                    deviderView,
                    totalPaymentAmountStackView)
        titleStackView.addArrangedSubviews(titleLabel, passengerLabel)
        usageAmountStackView.addArrangedSubviews(usageAmountTextLabel, usageAmountLabel)
        discountAndPointStackView.addArrangedSubviews(discountAndPointTextLabel, discountAndPointLabel)
        totalPaymentAmountStackView.addArrangedSubviews(totalPaymentAmountTextLabel, totalPaymentAmountLabel)

    }
    
    private func setLayout() {
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        usageAmountStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        discountAndPointStackView.snp.makeConstraints {
            $0.top.equalTo(usageAmountStackView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        deviderView.snp.makeConstraints {
            $0.top.equalTo(discountAndPointStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        totalPaymentAmountStackView.snp.makeConstraints {
            $0.top.equalTo(deviderView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
