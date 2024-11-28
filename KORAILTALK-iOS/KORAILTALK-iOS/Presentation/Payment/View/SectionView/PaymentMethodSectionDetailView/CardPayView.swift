//
//  CardPayView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

import SnapKit
import Then

enum CardPayTextFieldType: Int {
    case cardNumber
    case expirationDate
    case password
    case verificationCode
    
    var title: String {
        switch self {
        case .cardNumber:
            return "카드번호"
        case .expirationDate:
            return "유효기간"
        case .password:
            return "비밀번호"
        case .verificationCode:
            return "인증번호"
        }
    }
    
    var placeholder: String {
        switch self {
        case .cardNumber:
            return "0000 - 0000 - 0000 - 0000"
        case .expirationDate:
            return "00 / 00"
        case .password:
            return "00"
        case .verificationCode:
            return "주민번호 앞 6자리"
        }
    }
}

final class CardPayView: UIView {
    
    //MARK: - UI Properties
    
    let mostUsedCardButton = KorailDropDownButton(dropDownType: .enableForNoneCard, titleText: "자주쓰는카드")
    private let cardNumberTextField = UITextField()
    private let cardScanButton = UIButton()
    private let cardInfoStackView = UIStackView()
    private let expirationDateTextField = UITextField()
    private let passwordTextField = UITextField()
    let cardTypeButton = KorailDropDownButton(dropDownType: .enableForCard, titleText: "카드종류", optionText: "개인")
    private let verificationCodeTextField = UITextField()
    let installmentPeriodButton = KorailDropDownButton(dropDownType: .enableForCard, titleText: "할부기간", optionText: "일시불")
    private let verticalStackView = UIStackView()
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

extension CardPayView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        expirationDateTextField.becomeFirstResponder()
        
        [cardNumberTextField, expirationDateTextField, passwordTextField, verificationCodeTextField].enumerated().forEach { i, textField in
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 40)).then {
                let leftTextLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 42, height: 40)).then {
                    $0.text = CardPayTextFieldType(rawValue: i)?.title
                    $0.textColor = .korailBasic(.black)
                    $0.font = .korailCaption(.caption2m12)
                }
                
                $0.addSubview(leftTextLabel)
            }
            
            textField.tag = i
            textField.keyboardType = .numberPad
            textField.setPlaceholder(placeholder: CardPayTextFieldType(rawValue: i)?.placeholder ?? "", fontColor: .korailGrayscale(.gray400), font: .korailBody(.body2m14))
            textField.setTextFont(font: .korailBody(.body2m14), fontColor: .korailBlue(.blue01))
            textField.textAlignment = .right
            textField.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            textField.makeCornerRadius(cornerRadius: 8)
            textField.leftView = leftView
            textField.leftViewMode = .always
            
            switch textField {
            case passwordTextField:
                
                let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40)).then{
                    let rightTextLabel = UILabel(frame: CGRect(x: 4, y: 0, width: 28, height: 40)).then {
                        $0.text = "••"
                        $0.textColor = .korailGrayscale(.gray800)
                        $0.font = .korailBody(.body2m14)
                    }
                    
                    $0.addSubview(rightTextLabel)
                }
                
                textField.isSecureTextEntry = true
                textField.rightView = rightView
                textField.rightViewMode = .always
            case verificationCodeTextField:
                textField.isSecureTextEntry = true
                textField.addPadding(right: 12)
            default:
                textField.addPadding(right: 12)
            }
        }
        
        [mostUsedCardButton, cardTypeButton, installmentPeriodButton].enumerated().forEach { i, button in
            button.tag = i
        }
        
        cardScanButton.do {
            $0.setImage(.btnPaymentCardscan, for: .normal)
        }
        
        cardInfoStackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 4
        }
        
        verticalStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        
        checkBoxButton.do {
            $0.setImage(.property1BtnPaymentCheckboxSquareDefault, for: .normal)
            $0.setImage(.property1BtnPaymentCheckboxSquareSelected, for: .selected)
        }
    }
    
    private func setHierarchy() {
        addSubviews(verticalStackView, checkBoxButton)
        verticalStackView.addArrangedSubviews(mostUsedCardButton, cardInfoStackView, expirationDateTextField, passwordTextField, cardTypeButton, verificationCodeTextField, installmentPeriodButton)
        cardInfoStackView.addArrangedSubviews(cardNumberTextField, cardScanButton)
    }
    
    private func setLayout() {
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(328)
        }
        
        cardScanButton.snp.makeConstraints {
            $0.width.equalTo(66)
        }
        
        checkBoxButton.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    func highlightText(_ text: String, targetText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)

        let regex = try? NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: targetText), options: [])
        let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        
        matches?.forEach { match in
            attributedString.addAttribute(.foregroundColor, value: UIColor.korailGrayscale(.gray400), range: match.range)
        }
        
        return attributedString
    }
    
    func isHyundaiCardSelected(_ bool: Bool) {
        if bool {
            mostUsedCardButton.changeOptionLabelState(isHidden: false, text: "내 현대카드", textColor: .korailBlue(.blue01))
            cardNumberTextField.attributedText = highlightText("5702 - **** - **** - 5702", targetText: "-")
            expirationDateTextField.attributedText = highlightText("03 / 28", targetText: "/")
        } else {
            mostUsedCardButton.changeOptionLabelState(isHidden: false, text: "등록된 카드가 없습니다.", textColor: .korailGrayscale(.gray400))
            cardNumberTextField.text = ""
            expirationDateTextField.text = ""
        }
        passwordTextField.text = bool ? "**" : ""
        verificationCodeTextField.text = bool ? "******" : ""
    }
}
