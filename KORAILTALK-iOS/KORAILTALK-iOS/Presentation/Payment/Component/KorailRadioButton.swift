//
//  KorailRadioButton.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/22/24.
//

import UIKit

import SnapKit
import Then

enum RadioButtonType: Int {
    case ktxMileage
    case discountCoupon
    case pointUsage
    case simplePay
    case cardPay
    
    var title: String {
        switch self {
        case .ktxMileage:
            return "KTX 마일리지"
        case .discountCoupon:
            return "할인쿠폰"
        case .pointUsage:
            return "포인트 사용"
        case .simplePay:
            return "간편결제"
        case .cardPay:
            return "카드결제"
        }
    }
}

final class KorailRadioButton: UIButton {
    
    //MARK: - Properties
    
    private let titleText: String?

    //MARK: - UI Properties
    
    private let radioButton = UIButton()
        
    // MARK: - Life Cycle
    
    init(buttonType: RadioButtonType) {
        self.titleText = buttonType.title
        
        super.init(frame: .zero)
        
        setStyle(buttonType: buttonType)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KorailRadioButton {
    
    // MARK: - Layout
    
    private func setStyle(buttonType: RadioButtonType) {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(buttonType.title, attributes: AttributeContainer([.font: UIFont.korailBody(.body1sb14), .foregroundColor: UIColor.korailGrayscale(.gray800)]))
        configuration.image = .btnPaymentRadioDefault
        configuration.imagePlacement = .leading
        configuration.imagePadding = 6
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        
        self.configuration = configuration
        self.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.image = button.isSelected ? .btnPaymentRadioSelected : .btnPaymentRadioDefault
            
            button.configuration = config
        }
    }
}
