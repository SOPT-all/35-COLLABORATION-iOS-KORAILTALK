//
//  VeteranDiscountView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/25/24.
//

import UIKit

import SnapKit
import Then

enum VeteranDiscountTextFieldType: Int {
    case veteranID
    case password
    case verificationCode
    
    var title: String {
        switch self {
        case .veteranID:
            return "보훈번호"
        case .password:
            return "비밀번호"
        case .verificationCode:
            return "인증번호"
        }
    }
    
    var placeholder: String {
        switch self {
        case .veteranID:
            return "보훈번호 8자리"
        case .password:
            return "숫자 4자리(최초 주민번호 앞 4자리)"
        case .verificationCode:
            return "주민번호 앞자리 6자리"
        }
    }
    
    var maxLength: Int {
        switch self {
        case .veteranID:
            return 8
        case .password:
            return 4
        case .verificationCode:
            return 6
        }
    }
}

final class VeteranDiscountView: ModalBaseView {
    
    //MARK: - UI Properties
    
    let veteranIDTextField = UITextField()
    let passwordTextField = UITextField()
    let verificationCodeField = UITextField()
    let checkVeteranIDButton = UIButton()
    private let verificationInputStackView = UIStackView()
    private let applyTargetButton = KorailDropDownButton(dropDownType: .enanbleForSeat, titleText: "적용대상", optionText: "어른 - 7호차 16A / 12,500원")
    private let verticalStackView = UIStackView()
    lazy var toolBarButton = KorailToolBarButton(buttonType: .applyDiscpunt)

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

extension VeteranDiscountView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        veteranIDTextField.becomeFirstResponder()
        
        titleLabel.text = "국가유공자 할인"
        
        [veteranIDTextField, passwordTextField, verificationCodeField].enumerated().forEach { i, textField in
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 40)).then {
                let leftTextLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 42, height: 40)).then {
                    $0.text = VeteranDiscountTextFieldType(rawValue: i)?.title
                    $0.textColor = .korailBasic(.black)
                    $0.font = .korailCaption(.caption2m12)
                }
                
                $0.addSubview(leftTextLabel)
            }
            
            textField.tag = i
            textField.keyboardType = .numberPad
            textField.inputAccessoryView = toolBarButton
            textField.setPlaceholder(placeholder: VeteranDiscountTextFieldType(rawValue: i)?.placeholder ?? "", fontColor: .korailGrayscale(.gray400), font: .korailBody(.body2m14))
            textField.setTextFont(font: .korailBody(.body2m14), fontColor: .korailBlue(.blue01))
            textField.textAlignment = .right
            textField.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            textField.makeCornerRadius(cornerRadius: 8)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.addPadding(right: 12)
        }
        
        checkVeteranIDButton.do {
            $0.setImage(.btnCouponPatriotdiscountPatriotnumber, for: .normal)
            $0.isEnabled = false
        }
        
        verificationInputStackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 4
        }
        
        verticalStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
    }
    
    private func setHierarchy() {
        addSubviews(verticalStackView)
        verticalStackView.addArrangedSubviews(veteranIDTextField, passwordTextField, verificationInputStackView, applyTargetButton)
        verificationInputStackView.addArrangedSubviews(verificationCodeField, checkVeteranIDButton)
    }
    
    private func setLayout() {
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(184)
        }
        
        checkVeteranIDButton.snp.makeConstraints {
            $0.width.equalTo(90)
        }
    }
}
