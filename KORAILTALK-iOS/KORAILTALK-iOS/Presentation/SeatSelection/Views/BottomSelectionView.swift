//
//  BottomSelectionView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/26/24.
//

import UIKit

import SnapKit
import Then

protocol BottomSelectionViewDelegate: AnyObject {
    func completeButtonTapped()
}

class BottomSelectionView: UIView {

    // MARK: - Properties
    
    weak var delegate: BottomSelectionViewDelegate?
    private var selectedSeatID: Int? {
        didSet {
            updateCountLabel()
            updateButtonState()
        }
    }
    
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    private let completeButton = UIButton()
    
    // MARK: - Initializer
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomSelectionView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.text = "좌석을 선택해주세요"
            $0.font = .korailTitle(.title1sb18)
            $0.textColor = .korailBasic(.black)
        }
        
        countLabel.do {
            $0.textAlignment = .right
        }
        
        completeButton.do {
            var config = UIButton.Configuration.filled()
            config.attributedTitle = AttributedString(NSAttributedString.makeAttributedString(
                text: "선택 완료",
                color: .korailBasic(.white),
                font: .korailTitle(.title3m16)
            ))
            config.baseBackgroundColor = .korailGrayscale(.gray200)
            config.cornerStyle = .capsule
            $0.configuration = config
        }
        
        updateCountLabel()
    }
    
    private func setHierarchy() {
        self.addSubviews(
            titleLabel,
            countLabel,
            completeButton
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
    
    private func setAction() {
        let completeButtonTapped = UIAction { [weak self] _ in
            self?.delegate?.completeButtonTapped()
        }
        completeButton.addAction(completeButtonTapped, for: .touchUpInside)
    }
    
    private func updateCountLabel() {
        let selectedCount = selectedSeatID != nil ? "1" : "0"
        
        let attributedString = NSMutableAttributedString()
        
        let countAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.korailHead(.head5m20),
            .foregroundColor: UIColor.korailBasic(.black)
        ]
        attributedString.append(NSAttributedString(string: selectedCount, attributes: countAttributes))
        
        let separatorAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.korailTitle(.title3m16),
            .foregroundColor: UIColor.korailBasic(.black)
        ]
        attributedString.append(NSAttributedString(string: "/1", attributes: separatorAttributes))
        
        countLabel.attributedText = attributedString
    }
    
    private func updateButtonState() {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(NSAttributedString.makeAttributedString(
            text: "선택 완료",
            color: .korailBasic(.white),
            font: .korailTitle(.title3m16)
        ))
        
        if selectedSeatID != nil {
            config.baseBackgroundColor = .korailBlue(.blue03)
            completeButton.isEnabled = true
        } else {
            config.baseBackgroundColor = .korailGrayscale(.gray200)
            completeButton.isEnabled = false
        }
        
        config.cornerStyle = .capsule
        completeButton.configuration = config
    }
    
    // MARK: - Func
    
    func updateSelection(_ seatID: Int?) {
        self.selectedSeatID = seatID
    }
    
}
