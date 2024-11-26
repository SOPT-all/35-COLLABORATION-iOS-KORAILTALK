//
//  OutletPopupViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/26/24.
//

import UIKit

import SnapKit
import Then

final class OutletPopupViewController: BasePopupViewController {

    // MARK: - UI Properties
    
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHierarchy()
        setLayout()
    }

}

extension OutletPopupViewController {
    
    // MARK: - Layout
    
    private func setStyle() {
        setTitle("콘센트 확인")
        
        descriptionLabel.do {
            $0.text = "USB-A 타입의 포트 2개와 220V 콘센트 하나가 벽면에 제공되\n나, 모든 좌석에 제공되지 않으니 좌석을 확인하시기 바랍니다."
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailGrayscale(.gray600)
            $0.numberOfLines = 0
        }
        
        imageView.do {
            $0.image = .rectangle174.withRenderingMode(.alwaysOriginal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(
            descriptionLabel,
            imageView
        )
    }
    
    private func setLayout() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(246)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
}
