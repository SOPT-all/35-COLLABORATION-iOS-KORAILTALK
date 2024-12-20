//
//  TrainPriceButton.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/22/24.
//

import UIKit

enum TrainInfoButtonType {
    case standardSell
    case standardSoldOut
    case premiumSell
    case premiumSoldOut
}

final class TrainPriceButton: UIButton {
    
    var buttonConfiguration = UIButton.Configuration.plain()
    var type: TrainInfoButtonType = .standardSell {
        didSet {
            setStyle()
        }
    }
    var price: Int = 0 {
        didSet {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(for: price)
            priceText = "\(result ?? "")원"
            setStyle()
        }
    }
    
    private var titleText: String = "일반실"
    private var priceText: String = "매진"

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        
        var titleContainer = AttributeContainer()
        titleContainer.font = .korailCaption(.caption2m12)
        
        var subtitleContainer = AttributeContainer()
        subtitleContainer.font = .korailBody(.body2m14)

        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 9, bottom: 14, trailing: 9)
        buttonConfiguration.titlePadding = 0
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.titleAlignment = .center
        buttonConfiguration.background.strokeColor = .korailGrayscale(.gray400)
        buttonConfiguration.cornerStyle = .fixed
        buttonConfiguration.background.cornerRadius = 12
        
        switch type {
        case .standardSell:
            titleText = "일반실"
            titleContainer.foregroundColor = .korailBlue(.blue02)
            subtitleContainer.foregroundColor = .korailBasic(.black)
            buttonConfiguration.background.strokeColor = .korailBlue(.blue02)
            if isSelected {
                buttonConfiguration.baseBackgroundColor = .korailBlue(.blue06)
            }
        case .standardSoldOut:
            titleText = "일반실"
            titleContainer.foregroundColor = .korailGrayscale(.gray400)
            subtitleContainer.foregroundColor = .korailGrayscale(.gray400)
            buttonConfiguration.background.strokeColor = .korailGrayscale(.gray400)
            buttonConfiguration.background.backgroundColor = .korailGrayscale(.gray300)
            isEnabled = true
            priceText = "매진"
        case .premiumSell:
            titleText = "특/우등"
            titleContainer.foregroundColor = .korailBlue(.blue02)
            subtitleContainer.foregroundColor = .korailBasic(.black)
            buttonConfiguration.background.strokeColor = .korailBlue(.blue02)
            isEnabled = true
        case .premiumSoldOut:
            titleText = "특/우등"
            titleContainer.foregroundColor = .korailGrayscale(.gray400)
            subtitleContainer.foregroundColor = .korailGrayscale(.gray400)
            buttonConfiguration.background.strokeColor = .korailGrayscale(.gray400)
            buttonConfiguration.background.backgroundColor = .korailGrayscale(.gray300)
            isEnabled = true
            priceText = "매진"
        }
        
        buttonConfiguration.title = titleText
        buttonConfiguration.subtitle = priceText
        
        buttonConfiguration.attributedTitle = AttributedString(titleText, attributes: titleContainer)
        buttonConfiguration.attributedSubtitle = AttributedString(priceText, attributes: subtitleContainer)
        configuration = buttonConfiguration
    }
    
}

