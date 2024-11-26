//
//  ModalBaseView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/25/24.
//

import UIKit

import SnapKit
import Then

class ModalBaseView: UIView {

    //MARK: - UI Properties
    
    let titleLabel = UILabel()
    let xButton = UIButton()

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

extension ModalBaseView {
    
    // MARK: - Layout
    
    private func setStyle() {
        makeCornerRadius(cornerRadius: 10, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        titleLabel.do {
            $0.font = .korailTitle(.title1sb18)
            $0.textColor = .korailBasic(.black)
        }
        
        xButton.do {
            $0.setImage(.icnX38, for: .normal)
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, xButton)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalToSuperview().inset(22)
        }
        
        xButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
