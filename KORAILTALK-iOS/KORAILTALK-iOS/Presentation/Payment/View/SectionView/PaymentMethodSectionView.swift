//
//  PaymentMethodSectionView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

import SnapKit
import Then

final class PaymentMethodSectionView: UIView {

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    let simplePayRadioButton = KorailRadioButton(buttonType: .simplePay)
    let cardPayRadioButton = KorailRadioButton(buttonType: .cardPay)
    lazy var simplePayDetailView = SimplePayView()
    lazy var cardPayDetailView = CardPayView()
    private let simplePayStackView = UIStackView()
    private let cardPayStackView = UIStackView()

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

extension PaymentMethodSectionView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.text = "결제수단 선택"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title1sb18)
        }
        
        [simplePayStackView, cardPayStackView].forEach { stackView in
            stackView.backgroundColor = .clear
            stackView.axis = .vertical
            stackView.spacing = 12
            stackView.alignment = .leading
            stackView.distribution = .equalSpacing
        }
        
        [simplePayDetailView, cardPayDetailView].forEach { view in
            view.isHidden = true
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, simplePayStackView, cardPayStackView)
        simplePayStackView.addArrangedSubviews(simplePayRadioButton, simplePayDetailView)
        cardPayStackView.addArrangedSubviews(cardPayRadioButton, cardPayDetailView)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        [simplePayRadioButton, cardPayRadioButton].forEach { button in
            button.snp.makeConstraints {
                $0.height.equalTo(28)
            }
        }
        
        simplePayStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        simplePayDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        cardPayStackView.snp.makeConstraints {
            $0.top.equalTo(simplePayStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        cardPayDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    //MARK: - Func
    
    func toggleDropDownState(sender: UIButton) {
        switch sender {
        case simplePayRadioButton:
            simplePayRadioButton.isSelected.toggle()
            simplePayDetailView.isHidden = !simplePayRadioButton.isSelected
            
            cardPayRadioButton.isSelected = false
            cardPayDetailView.isHidden = true
        case cardPayRadioButton:
            endEditing(true)
            cardPayRadioButton.isSelected.toggle()
            cardPayDetailView.isHidden = !cardPayRadioButton.isSelected

            simplePayRadioButton.isSelected = false
            simplePayDetailView.isHidden = true
         default:
            return
        }
    }
}
