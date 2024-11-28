//
//  MyTicketRoundedStrokeButton.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/27/24.
//

import UIKit

final class MyTicketRoundedStrokeButton: UIButton {

    private var buttonConfiguration = UIButton.Configuration.filled()
    private var title: String = ""
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.title = title
        setStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        buttonConfiguration.baseBackgroundColor = .korailBasic(.white)
        buttonConfiguration.attributedTitle = NSAttributedString.makeAttributedString(
            text: title,
            color: .korailBlue(.blue01),
            font: .korailBody(.body2m14)
        )
        buttonConfiguration.background.cornerRadius = 20
        buttonConfiguration.background.strokeColor = .korailGrayscale(.gray200)
        
        configuration = buttonConfiguration
    }
}
