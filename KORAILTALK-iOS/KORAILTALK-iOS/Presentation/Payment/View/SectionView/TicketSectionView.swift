//
//  TicketSectionView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

import SnapKit
import Then

final class TicketSectionView: UIView {

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let labelStackView = UIStackView()
    private let descriptioLabel = UILabel()
        
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

extension TicketSectionView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.text = "승차권"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title1sb18)
        }
        
        priceLabel.do {
            $0.text = "12,500원"
            $0.textColor = .korailPurple(.purple04)
            $0.textAlignment = .center
            $0.font = .korailHead(.head5m20)
        }
        
        labelStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .center
            $0.addArrangedSubviews(titleLabel, priceLabel)
        }
        
        descriptioLabel.do {
            $0.text = "*특(우등)실은 운임과 요금으로 구성되며 운임만 할인됨"
            $0.textColor = .korailBasic(.red)
            $0.textAlignment = .center
            $0.font = .korailCaption(.caption2m12)
        }
    }
    
    private func setHierarchy() {
        addSubviews(labelStackView, descriptioLabel)
    }
    
    private func setLayout() {
        labelStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
        }
        
        descriptioLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
