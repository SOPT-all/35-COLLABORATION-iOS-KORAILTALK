//
//  SimplePayView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

import SnapKit
import Then

final class SimplePayView: UIView {

    //MARK: - UI Properties
    
    private let korailTosspayButton = UIButton()
    let simplePayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

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

extension SimplePayView {
    
    // MARK: - Layout
    
    private func setStyle() {
        korailTosspayButton.do {
            $0.makeCornerRadius(cornerRadius: 8)
            $0.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            $0.backgroundColor = .korailBasic(.white)

            var configuration = UIButton.Configuration.plain()
            configuration.attributedTitle = AttributedString("+ 결제수단 등록하기", attributes: AttributeContainer([.font: UIFont.korailCaption(.caption2m12), .foregroundColor: UIColor.korailGrayscale(.gray400)]))
            configuration.image = .imgKorailXtossLogo.resized(CGSize(width: 179, height: 24))
            configuration.imagePlacement = .leading
            configuration.imagePadding = 8
            configuration.baseBackgroundColor = .clear
            
            $0.configuration = configuration
        }
        
        simplePayCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.minimumLineSpacing = 8
            
            $0.collectionViewLayout = flowLayout
            $0.register(SimplePayCollectionViewCell.self, forCellWithReuseIdentifier: SimplePayCollectionViewCell.className)

            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
    }
    
    private func setHierarchy() {
        addSubviews(korailTosspayButton, simplePayCollectionView)
    }
    
    private func setLayout() {
        korailTosspayButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        simplePayCollectionView.snp.makeConstraints {
            $0.top.equalTo(korailTosspayButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(212)
            $0.bottom.equalToSuperview()
        }
    }
}
