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
    
    //MARK: - Properties
    
    private var dateButtonConfiguration = UIButton.Configuration.plain()
    private var selectButtonConfiguration = UIButton.Configuration.plain()
    
    weak var delegate: FilterDelegate?

    //MARK: - Life Cycle
    
    init() {
        
        super.init(frame: .zero)
        
        setStyle()
        setHierachy()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TrainSearchFilterView {
    
    private func setStyle() {
        
        var dateContainer = AttributeContainer()
        dateContainer.font = UIFont.korailTitle(.title3m16)
        dateContainer.foregroundColor = UIColor.korailBasic(.black)
        
        if let resizedImage = UIImage(resource: .icnSearchArrowDown)
            .resized(CGSize(width: 24, height: 24)) {
            dateButtonConfiguration.image = resizedImage
        } else { return }
        
        dateButtonConfiguration.imagePlacement = .trailing
        dateButtonConfiguration.contentInsets = .zero
        dateButtonConfiguration.imagePadding = 0
        //TODO: 날짜 설정 해야 함
        dateButtonConfiguration.attributedTitle = AttributedString("2024.11.11 (토)", attributes: dateContainer)
        
        var selectContainer = AttributeContainer()
        selectContainer.font = UIFont.korailBody(.body2m14)
        selectContainer.foregroundColor = UIColor.korailGrayscale(.gray500)
        
        if let resizedImage = UIImage(resource: .icnTrainSearchArrowDown)
            .resized(CGSize(width: 18, height: 18)) {
            selectButtonConfiguration.image = resizedImage
        } else { return }
        
        selectButtonConfiguration.imagePlacement = .trailing
        selectButtonConfiguration.contentInsets = .zero
        selectButtonConfiguration.imagePadding = 4

        let selectButtons = [
            trainSelectButton,
            seatSelectButton,
            transferSelectButton
        ]
        
        selectButtons.enumerated().forEach { index, button in
            
            button.configuration = selectButtonConfiguration
            
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
            
            // stackview에 padding 주기
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 12,
                leading: 16,
                bottom: 12,
                trailing: 10
            )
        }

        dateButton.do {
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.configuration = dateButtonConfiguration
        }
        
        selectStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
        
        trainSelectButton.do {
            $0.addTarget(self, action: #selector(trainSelectButtonTapped), for: .touchUpInside)
        }
        seatSelectButton.do {
            $0.addTarget(self, action: #selector(seatSelectButtonTapped), for: .touchUpInside)
        }
        transferSelectButton.do {
            $0.addTarget(self, action: #selector(transferSelectButtonTapped), for: .touchUpInside)
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
            $0.width.equalTo(129)
        }
        
        selectStackView.snp.makeConstraints {
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
    
    @objc
    func trainSelectButtonTapped() {
        delegate?.showBottomSheet(title: "모든열차", bottomType: .blue, listType: trainList)
    }
    
    @objc
    func seatSelectButtonTapped() {
        delegate?.showBottomSheet(title: "일반석", bottomType: .blue, listType: seatList)
    }
    
    @objc
    func transferSelectButtonTapped() {
        delegate?.showBottomSheet(title: "직통", bottomType: .blue, listType: transferList)
    }
}
