//
//  KorailToolBarButton.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/25/24.
//

import UIKit

import SnapKit
import Then

enum ToolBarButtonType: Int {
    case done
    case applyDiscpunt
    case applyPoint
    
    var title: String {
        switch self {
        case .done:
            return "입력 완료"
        case .applyDiscpunt:
            return "할인 적용"
        case .applyPoint:
            return "포인트 적용"
        }
    }
}

final class KorailToolBarButton: UIButton {
        
    // MARK: - Life Cycle
    
    init(buttonType: ToolBarButtonType) {
        super.init(frame: .zero)
        
        setStyle(buttonType: buttonType)
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KorailToolBarButton {
    
    // MARK: - Layout
    
    private func setStyle(buttonType: ToolBarButtonType) {
        setTitle(buttonType.title, for: .normal)
        setTitleColor(.korailBasic(.white), for: .normal)
        titleLabel?.font = .korailTitle(.title3m16)
        backgroundColor = .korailGrayscale(.gray200)
        isEnabled = false
    }
    
    //MARK: - Func
    
    func changeButtonState(isEnabled: Bool) {
        if isEnabled {
            backgroundColor = .korailPurple(.purple03)
            self.isEnabled = true
        } else {
            backgroundColor = .korailGrayscale(.gray200)
            self.isEnabled = false
        }
    }
}
