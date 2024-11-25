//
//  KTXMileageView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/22/24.
//

import UIKit

import SnapKit
import Then

final class KTXMileageView: UIView {
    
    //MARK: - Properties
    
    private var usableMileageValue = "2000"

    //MARK: - UI Properties
    
    let mileageTextField = UITextField()
    let applyAllAmountButton = UIButton()
    private let mileageInputStackView = UIStackView()
    private let usableMileageLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let mileageLabelStackView = UIStackView()
    lazy var toolBarButton = KorailToolBarButton(buttonType: .done)

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

extension KTXMileageView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        mileageTextField.do {
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 40)).then {
                let leftTextLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 42, height: 40)).then {
                    $0.text = "마일리지"
                    $0.textColor = .korailBasic(.black)
                    $0.font = .korailCaption(.caption2m12)
                }
                
                $0.addSubview(leftTextLabel)
            }
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 33, height: 40)).then{
                let rightTextLabel = UILabel(frame: CGRect(x: 4, y: 0, width: 13, height: 40)).then {
                    $0.text = "점"
                    $0.textColor = .korailGrayscale(.gray900)
                    $0.font = .korailBody(.body2m14)
                }
                
                $0.addSubview(rightTextLabel)
            }
            
            $0.delegate = self
            $0.keyboardType = .numberPad
            $0.inputAccessoryView = toolBarButton
            $0.setPlaceholder(placeholder: "2000", fontColor: .korailGrayscale(.gray300), font: .korailBody(.body2m14))
            $0.setTextFont(font: .korailBody(.body2m14), fontColor: .korailBlue(.blue01))
            $0.textAlignment = .right
            $0.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            $0.makeCornerRadius(cornerRadius: 8)
            $0.leftView = leftView
            $0.leftViewMode = .always
            $0.rightView = rightView
            $0.rightViewMode = .always
        }
        
        applyAllAmountButton.do {
            $0.setImage(.btnPaymentAdjust, for: .normal)
        }
        
        mileageInputStackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.spacing = 4
        }
        
        usableMileageLabel.do {
            $0.text = "사용 가능 마일리지: \(usableMileageValue)점"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailGrayscale(.gray500)
            $0.textAlignment = .center
        }
        
        descriptionLabel.do {
            $0.text = "100마일리지 이상 100마일리지 단위로 사용"
            $0.font = .korailCaption(.caption4m10)
            $0.textColor = .korailGrayscale(.gray400)
            $0.textAlignment = .center
        }
        
        mileageLabelStackView.do {
            $0.axis = .vertical
            $0.alignment = .trailing
            $0.spacing = 4
        }
    }
    
    private func setHierarchy() {
        addSubviews(mileageInputStackView, mileageLabelStackView)
        mileageInputStackView.addArrangedSubviews(mileageTextField, applyAllAmountButton)
        mileageLabelStackView.addArrangedSubviews(usableMileageLabel, descriptionLabel)
    }
    
    private func setLayout() {
        mileageInputStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        applyAllAmountButton.snp.makeConstraints {
            $0.width.equalTo(66)
        }
        
        mileageLabelStackView.snp.makeConstraints {
            $0.top.equalTo(mileageInputStackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: - Func
    
    func applyAllAmount() {
        mileageTextField.text = "2000"
        toolBarButton.changeButtonState(isEnabled: true)
    }
}

extension KTXMileageView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let inputNum = textField.text {
            toolBarButton.changeButtonState(isEnabled: true)
            if Int(inputNum) ?? 0 >= 2000 {
                textField.text = "2000"
            } else if Int(inputNum) == 0 {
                toolBarButton.changeButtonState(isEnabled: false)
                textField.text = "0"
            } else if inputNum.first == "0" && inputNum.count > 1 {
                textField.text?.removeFirst()
            }
        }
        if textField.text == "" {
            toolBarButton.changeButtonState(isEnabled: false)
        }
    }
}
