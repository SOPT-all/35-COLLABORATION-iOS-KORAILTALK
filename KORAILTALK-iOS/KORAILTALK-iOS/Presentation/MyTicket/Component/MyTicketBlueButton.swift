//
//  MyTicketBlueButton.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/27/24.
//

import UIKit

final class MyTicketBlueButton: UIButton {

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
        buttonConfiguration.baseBackgroundColor = .korailBlue(.blue07)
        buttonConfiguration.background.cornerRadius = 8
        buttonConfiguration.attributedTitle = NSAttributedString.makeAttributedString(
            text: title,
            color: .korailBlue(.blue01),
            font: .korailTitle(.title3m16)
        )
        
        configuration = buttonConfiguration
    }
    
}
