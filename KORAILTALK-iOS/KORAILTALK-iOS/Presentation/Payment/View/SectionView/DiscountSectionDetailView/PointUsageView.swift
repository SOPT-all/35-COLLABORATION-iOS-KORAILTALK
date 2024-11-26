//
//  PointUsageView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/25/24.
//

import UIKit

import SnapKit
import Then

final class PointUsageView: UIView {

    //MARK: - UI Properties
    
    let lPointButton = UIButton()
    private let railPointButton = UIButton()
    private let webeeHoneyButton = UIButton()
    private let cityPoinButton = UIButton()
    private let okCashBackButton = UIButton()
    private let verticalStackView = UIStackView()
    private let horizontalStackView1 = UIStackView()
    private let horizontalStackView2 = UIStackView()

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

extension PointUsageView {
    
    // MARK: - Layout
    
    private func setStyle() {
        [lPointButton, railPointButton, webeeHoneyButton, cityPoinButton, okCashBackButton].forEach { button in
            button.makeCornerRadius(cornerRadius: 8)
            button.titleLabel?.font = .korailCaption(.caption2m12)
            switch button {
            case lPointButton, railPointButton, okCashBackButton:
                button.backgroundColor = .korailBasic(.white)
                button.setTitleColor(.korailBasic(.black), for: .normal)
                button.makeBorder(width: 1, color: .korailGrayscale(.gray200))
            default:
                button.backgroundColor = .korailGrayscale(.gray200)
                button.setTitleColor(.korailGrayscale(.gray400), for: .normal)
            }
        }
        
        lPointButton.setTitle("L.POINT", for: .normal)
        railPointButton.setTitle("레일포인트", for: .normal)
        webeeHoneyButton.setTitle("위비꿀 (모아)", for: .normal)
        cityPoinButton.setTitle("씨티포인트", for: .normal)
        okCashBackButton.setTitle("OK캐쉬백포인트", for: .normal)
        
        verticalStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        
        [horizontalStackView1, horizontalStackView2].forEach { stackView in
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fillEqually
        }
    }
    
    private func setHierarchy() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubviews(lPointButton, horizontalStackView1, horizontalStackView2)
        horizontalStackView1.addArrangedSubviews(railPointButton, webeeHoneyButton)
        horizontalStackView2.addArrangedSubviews(cityPoinButton, okCashBackButton)
    }
    
    private func setLayout() {
        verticalStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(124)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
