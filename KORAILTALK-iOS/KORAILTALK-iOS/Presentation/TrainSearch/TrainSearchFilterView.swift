//
//  TrainSearchFilterView.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

import SwiftUI

final class TrainSearchFilterView: UIView {

    // MARK: - UI Properties
    
    private let containerStackView = UIStackView()
    
    private let dateButton = UIButton()
    
    private let selectStackView = UIStackView()
    private let trainSelectButton = UIButton()
    private let seatSelectButton = UIButton()
    private let transferSelectButton = UIButton()
    
    private var dateButtonConfig = UIButton.Configuration.plain()
    private var selectButtonConfig = UIButton.Configuration.plain()

    init() {
        super.init(frame: .zero)
        setStyle()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        
        containerStackView.do {
            $0.axis = .horizontal
//            $0.backgroundColor = .red
            $0.alignment = .center
            $0.spacing = 27
        }

        
        dateButton.do {
//            dateButtonConfig.title = "2024.11.11 (토)"
            $0.
            dateButtonConfig.image = UIImage(resource: .icnSearchArrowDown)
            
            $0.configuration = dateButtonConfig
        }
        
        selectStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        
        
    }
    
    private func setHierachy() {
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubviews(dateButton, selectStackView)
        selectStackView.addArrangedSubviews(
            trainSelectButton,
            seatSelectButton,
            transferSelectButton
        )
        
    }
    
    private func setLayout() {
        
        containerStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        dateButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        
        selectStackView.snp.makeConstraints {
            //TODO: 이거 적용이 왜안되묘...
            $0.trailing.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        
    }
    
}
