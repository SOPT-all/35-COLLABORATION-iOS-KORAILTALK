//
//  PaymentActionsView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/27/24.
//

import UIKit

import SnapKit
import Then

protocol PaymentActionsViewDelegate: AnyObject {
    func saveButtonTapped()
    func payButtonTapped()
}

final class PaymentActionsView: UIView {
    
    weak var delegate: PaymentActionsViewDelegate?
    
    private let saveButton = UIButton()
    private let payButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentActionsView {
    
    private func setStyle() {
        self.backgroundColor = .korailBasic(.white)
        
        saveButton.do {
            var config = UIButton.Configuration.filled()
            config.attributedTitle = NSAttributedString.makeAttributedString(
                text: "담아두기",
                color: .korailBlue(.blue01),
                font: .korailTitle(.title3m16)
            )
            config.baseBackgroundColor = .korailBasic(.white)
            config.cornerStyle = .capsule
            $0.configuration = config
            $0.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            $0.makeCornerRadius(cornerRadius: 25)
        }
        
        payButton.do {
            var config = UIButton.Configuration.filled()
            config.attributedTitle =  NSAttributedString.makeAttributedString(
                text: "바로결제",
                color: .korailBasic(.white),
                font: .korailTitle(.title3m16)
            )
            config.baseBackgroundColor = .korailBlue(.blue03)
            config.cornerStyle = .capsule
            $0.configuration = config
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(
            saveButton,
            payButton
        )
    }
    
    private func setLayout() {
        saveButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.equalTo(174)
            $0.height.equalTo(50)
        }
        
        payButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(174)
            $0.height.equalTo(50)
        }
    }
    
    private func setActions() {
        let saveButtonTapped = UIAction { [weak self] _ in
            self?.delegate?.saveButtonTapped()
        }
        saveButton.addAction(saveButtonTapped, for: .touchUpInside)
        
        let payButtonTapped = UIAction { [weak self] _ in
            self?.delegate?.payButtonTapped()
        }
        payButton.addAction(payButtonTapped, for: .touchUpInside)
    }
    
}
