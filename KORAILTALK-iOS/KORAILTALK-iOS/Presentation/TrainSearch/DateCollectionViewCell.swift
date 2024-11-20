//
//  DateCollectionViewCell.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/20/24.
//

import UIKit

final class DateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let dateLable = PaddingLabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dateLable.textColor = .korailBasic(.white)
                dateLable.layer.backgroundColor = UIColor.korailBlue(.blue04).cgColor
            } else {
                dateLable.textColor = .korailGrayscale(.gray500)
                dateLable.layer.backgroundColor = UIColor.korailBasic(.white).cgColor
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
            $0.clipsToBounds = true
            //TODO: 물어보기.........20으로하면 고고마가됨..!!!!! ㅠㅠㅠ
            // 글자짤림이슈...
            $0.layer.cornerRadius = 16
            
            $0.textColor = .korailGrayscale(.gray500)
            $0.layer.backgroundColor = UIColor.korailBasic(.white).cgColor
        }
        
    }
    
    private func setHierachy() {
        addSubview(dateLable)
    }
    
    private func setLayout() {
        dateLable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//TODO: 이거 클래스 따로 빼서 작성해도 되는지? 어느 폴더에 위치해야 하는지?
final class PaddingLabel: UILabel {
    
    let horizontalPadding: CGFloat = 16
    let verticalPadding: CGFloat = 6
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalPadding * 2, height: size.height + verticalPadding * 2)
    }
}
