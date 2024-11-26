//
//  LPointModalView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

import SnapKit
import Then

enum LPointTextFieldType: Int {
    case password
    case point
    
    var title: String {
        switch self {
        case .password:
            return "포인트 비밀번호"
        case .point:
            return "사용 포인트"
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .password:
            return 6
        case .point:
            return nil
        }
    }
}

final class LPointModalView: ModalBaseView {
    
    //MARK: - Properties
    
    var pointAmouunt = "1483"
    
    //MARK: - UI Properties
    
    let pointPasswordTextField = UITextField()
    let checkPasswordButton = UIButton()
    private let pointPasswordInputStackView = UIStackView()
    let pointTextField = UITextField()
    let applyAllAmountButton = UIButton()
    private let pointInputStackView = UIStackView()
    private let usablePointLabel = UILabel()
    private let verticalStackView = UIStackView()
    lazy var toolBarButton = KorailToolBarButton(buttonType: .applyPoint)
    private let descriptionLabel = UILabel()
    let checkBoxButton = UIButton()

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

extension LPointModalView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        pointPasswordTextField.becomeFirstResponder()
        
        titleLabel.text = "L.POINT"
        
        [pointPasswordTextField, pointTextField].enumerated().forEach { i, textField in
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 40)).then {
                let leftTextLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 76, height: 40)).then {
                    $0.text = LPointTextFieldType(rawValue: i)?.title
                    $0.textColor = .korailBasic(.black)
                    $0.font = .korailCaption(.caption2m12)
                }
                
                $0.addSubview(leftTextLabel)
            }
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 29, height: 40)).then{
                let rightTextLabel = UILabel(frame: CGRect(x: 4, y: 0, width: 9, height: 40)).then {
                    $0.text = "P"
                    $0.textColor = .korailGrayscale(.gray900)
                    $0.font = .korailBody(.body2m14)
                }
                
                $0.addSubview(rightTextLabel)
            }
            
            textField.tag = i
            textField.keyboardType = .numberPad
            textField.inputAccessoryView = toolBarButton
            textField.setTextFont(font: .korailBody(.body2m14), fontColor: .korailBlue(.blue01))
            textField.textAlignment = .right
            textField.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            textField.makeCornerRadius(cornerRadius: 8)
            textField.leftView = leftView
            textField.leftViewMode = .always
            
            if textField == pointPasswordTextField {
                textField.addPadding(right: 12)
                textField.setPlaceholder(placeholder: "비밀번호 6자리", fontColor: .korailGrayscale(.gray400), font: .korailBody(.body2m14))
                textField.isSecureTextEntry = true
            } else if textField == pointTextField {
                textField.rightView = rightView
                textField.rightViewMode = .always
                textField.setPlaceholder(placeholder: pointAmouunt, fontColor: .korailGrayscale(.gray300), font: .korailBody(.body2m14))
                textField.isEnabled = false
            }
        }
        
        checkPasswordButton.do {
            $0.setImage(.btnPointLpointCheck, for: .normal)
            $0.isEnabled = false
        }
        
        applyAllAmountButton.do {
            $0.setImage(.btnPaymentAdjust, for: .normal)
            $0.isEnabled = false
        }
        
        [pointPasswordInputStackView, pointInputStackView].forEach { stackView in
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.spacing = 4
        }
        
        usablePointLabel.do {
            $0.text = "사용 가능 포인트: \(pointAmouunt)점"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailGrayscale(.gray500)
            $0.textAlignment = .center
        }
        
        verticalStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        
        descriptionLabel.do {
            $0.text = "100P 단위 사용 가능\n결제 비밀번호는 L.POINT 홈페이지 또는 앱에서 확인 가능\nL.POINT 일부 유형 포인트 사용 불가 (상품권 포인트, 전환적립, 및 판촉포인트 등)"
            $0.numberOfLines = 0
            $0.font = .korailCaption(.caption4m10)
            $0.textColor = .korailGrayscale(.gray500)
            $0.textAlignment = .left
        }
        
        checkBoxButton.do {
            $0.setImage(.property1BtnPaymentCheckboxSquareDefault, for: .normal)
            $0.setImage(.property1BtnPaymentCheckboxSquareSelected, for: .selected)
        }
    }
    
    private func setHierarchy() {
        addSubviews(verticalStackView, usablePointLabel, descriptionLabel, checkBoxButton)
        verticalStackView.addArrangedSubviews(pointPasswordInputStackView, pointInputStackView)
        pointPasswordInputStackView.addArrangedSubviews(pointPasswordTextField, checkPasswordButton)
        pointInputStackView.addArrangedSubviews(pointTextField, applyAllAmountButton)
    }
    
    private func setLayout() {
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(88)
        }
        
        usablePointLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        [checkPasswordButton, applyAllAmountButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalTo(66)
            }
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(usablePointLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        checkBoxButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Func
    
    func applyAllAmount() {
        pointTextField.text = pointAmouunt
    }
}
