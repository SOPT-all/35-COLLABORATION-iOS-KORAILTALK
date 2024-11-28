//
//  DateCollectionViewCell.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/20/24.
//

import UIKit

final class DateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let dateLable = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dateLable.textColor = .korailBasic(.white)
                backgroundColor = UIColor.korailBlue(.blue04)
            } else {
                dateLable.textColor = .korailGrayscale(.gray500)
                backgroundColor = UIColor.korailBasic(.white)
            }
        }
    }
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindData(_ date: String) {
        dateLable.text = date
    }
}

extension DateCollectionViewCell {
    
    private func setStyle() {
        
        dateLable.do {
            $0.font = .korailBody(.body3r14)
            $0.textColor = .korailGrayscale(.gray500)
        }
        
        backgroundColor = UIColor.korailBasic(.white)
        makeCornerRadius(cornerRadius: 17)
        
    }
    
    private func setHierachy() {
        addSubview(dateLable)
    }
    
    private func setLayout() {
        dateLable.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
