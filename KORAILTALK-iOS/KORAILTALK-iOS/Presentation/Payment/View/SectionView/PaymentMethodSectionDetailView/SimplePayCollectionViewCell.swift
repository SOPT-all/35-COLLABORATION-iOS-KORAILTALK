//
//  SimplePayCollectionViewCell.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

import SnapKit
import Then

final class SimplePayCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            changeCellState(isSelected)
        }
    }

    //MARK: - UI Properties
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let eventImageView = UIImageView(image: UIImage(resource: .imgPaymentEasypaymentEvent))
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .korailBasic(.white)
        makeBorder(width: 1, color: .korailGrayscale(.gray200))
        eventImageView.isHidden = true
    }
}

extension SimplePayCollectionViewCell {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        makeCornerRadius(cornerRadius: 8)
        makeBorder(width: 1, color: .korailGrayscale(.gray200))
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fill
            $0.alignment = .center
        }
        
        titleLabel.do {
            $0.text = ""
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailCaption(.caption2m12)
        }
        
        eventImageView.isHidden = true
    }
    
    private func setHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(titleLabel, eventImageView)
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //MARK: - Func
    
    func configureCell(data: SimplePayModel) {
        titleLabel.text = data.title
        eventImageView.isHidden = !data.includeEvent
    }
    
    func changeCellState(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = .korailBlue(.blue04)
            layer.borderWidth = 0
            titleLabel.textColor = .korailBasic(.white)
        } else {
            backgroundColor = .korailBasic(.white)
            makeBorder(width: 1, color: .korailGrayscale(.gray200))
            titleLabel.textColor = .korailBasic(.black)
        }
    }
}
