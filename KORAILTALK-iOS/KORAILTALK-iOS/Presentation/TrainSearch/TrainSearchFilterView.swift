//
//  TrainSearchFilterView.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

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
        
        var dateContainer = AttributeContainer()
        dateContainer.font = UIFont.korailTitle(.title3m16)
        dateContainer.foregroundColor = UIColor.korailBasic(.black)
        
        if let resizedImage = UIImage(resource: .icnSearchArrowDown)
            .resized(CGSize(width: 24, height: 24)) {
            dateButtonConfig.image = resizedImage
        } else { return }
        dateButtonConfig.imagePlacement = .trailing
        dateButtonConfig.contentInsets = .zero
        dateButtonConfig.imagePadding = 0
        //TODO: 날짜 설정 해야 함
        dateButtonConfig.attributedTitle = AttributedString("2024.11.11 (토)", attributes: dateContainer)
        
        var selectContainer = AttributeContainer()
        selectContainer.font = UIFont.korailBody(.body2m14)
        selectContainer.foregroundColor = UIColor.korailGrayscale(.gray500)
        
        
        if let resizedImage = UIImage(resource: .icnTrainSearchArrowDown)
            .resized(CGSize(width: 18, height: 18)) {
            selectButtonConfig.image = resizedImage
        } else { return }
        selectButtonConfig.imagePlacement = .trailing
        selectButtonConfig.contentInsets = .zero
        selectButtonConfig.imagePadding = 4
//        selectButtonConfig.attributedTitle = AttributedString("모든열차", attributes: selectContainer)
        
        let selectButtons = [trainSelectButton, seatSelectButton, transferSelectButton]
        
        selectButtons.enumerated().forEach { index, button in
            
            button.configuration = selectButtonConfig
            
            let titles = ["모든열차", "일반석", "직통"]
            
            var attributedTitle = AttributedString(titles[index])
            attributedTitle.font = UIFont.korailBody(.body2m14)
            attributedTitle.foregroundColor = UIColor.korailGrayscale(.gray500)
            button.configuration?.attributedTitle = attributedTitle
        }
        
        containerStackView.do {
            $0.axis = .horizontal
            $0.backgroundColor = UIColor.korailBlue(.blue07)
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 27
        }

        dateButton.do {
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.configuration = dateButtonConfig
        }
        
        selectStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
        
    }
    
    private func setHierachy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubviews(dateButton, selectStackView)
        
        containerStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 10)
        
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
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.width.equalTo(129)
        }
        
        selectStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.width.equalTo(193)
        }
        
        trainSelectButton.snp.makeConstraints {
            $0.width.equalTo(71)
        }
        seatSelectButton.snp.makeConstraints {
            $0.width.equalTo(59)
        }
        transferSelectButton.snp.makeConstraints {
            $0.width.equalTo(47)
        }
    
    }

}
