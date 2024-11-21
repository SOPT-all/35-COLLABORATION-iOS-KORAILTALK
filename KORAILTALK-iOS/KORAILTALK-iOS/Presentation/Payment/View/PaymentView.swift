//
//  PaymentView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

import SnapKit
import Then

final class PaymentView: UIView {

    //MARK: - UI Properties
        
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

extension PaymentView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .white
    }
    
    private func setHierarchy() {
//        addSubviews()
    }
    
    private func setLayout() {
        
    }
}
