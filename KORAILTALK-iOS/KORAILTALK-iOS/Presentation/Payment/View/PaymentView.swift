//
//  PaymentView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

import SnapKit
import Then

final class PaymentView: UIView {
    
    //MARK: - Properties
    
    private let totalAmount = 12500

    //MARK: - UI Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let ticketSectionView = TicketSectionView()
    let discountSectionView = DiscountSectionView()
    let paymentMethodSectionView = PaymentMethodSectionView()
    let paymentDetailSectionView = PaymentDetailSectionView()
    private let ticketPriceView = UIView()
    private let totalQuantityLabel = UILabel()
    private let totalPriceLabel = UILabel()
    private let ticketingButton = UIButton()
    private let buttonBackgroundView = UIView()
        
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

extension PaymentView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailGrayscale(.gray100)
        
        ticketPriceView.do {
            $0.backgroundColor = .korailTransparent(.blue95)
        }
        
        totalQuantityLabel.do {
            $0.text = "총 1매"
            $0.font = .korailBody(.body2m14)
            $0.textColor = .korailBasic(.white)
        }
        
        totalPriceLabel.do {
            $0.text = "12,500원"
            $0.font = .korailHead(.head5m20)
            $0.textColor = .korailBasic(.white)
        }
        
        ticketingButton.do {
            $0.setTitle("발권하기", for: .normal)
            $0.setTitleColor(.korailBasic(.white), for: .normal)
            $0.titleLabel?.font = .korailTitle(.title3m16)
            $0.makeCornerRadius(cornerRadius: 25)
            $0.backgroundColor = .korailGrayscale(.gray200)
        }
        
        buttonBackgroundView.do {
            $0.backgroundColor = .korailBasic(.white)
        }
    }
    
    private func setHierarchy() {
        addSubviews(scrollView, ticketPriceView, buttonBackgroundView)
        scrollView.addSubview(contentView)
        ticketPriceView.addSubviews(totalQuantityLabel, totalPriceLabel)
        buttonBackgroundView.addSubview(ticketingButton)
        contentView.addSubviews(ticketSectionView, discountSectionView, paymentMethodSectionView, paymentDetailSectionView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints{
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(ticketPriceView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.high)
        }
        
        ticketSectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(86)
        }
        
        discountSectionView.snp.makeConstraints {
            $0.top.equalTo(ticketSectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        paymentMethodSectionView.snp.makeConstraints {
            $0.top.equalTo(discountSectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        paymentDetailSectionView.snp.makeConstraints {
            $0.top.equalTo(paymentMethodSectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
        }
        
        ticketPriceView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(buttonBackgroundView.snp.top)
        }
        
        totalQuantityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        buttonBackgroundView.snp.makeConstraints {
            $0.height.equalTo(102)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        ticketingButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(42)
        }
    }
    
    //MARK: - Func
    
    func updatePaymentInfo(discountAmount: Int) {
        let totalString = "\(formatNumberWithComma(totalAmount - discountAmount))원"
        let discountString = "\(formatNumberWithComma(discountAmount))원"
        
        totalPriceLabel.text = totalString
        paymentDetailSectionView.totalPaymentAmountLabel.text = totalString
        paymentDetailSectionView.discountAndPointLabel.text = discountString
    }
}
