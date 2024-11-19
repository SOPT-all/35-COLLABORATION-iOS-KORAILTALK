//
//  CoachHeaderView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

import SnapKit
import Then

final class CoachHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    private let dateLabel = UILabel()
    private let departureLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let arrivalLabel = UILabel()
    
    // MARK: - Initializers
    
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

extension CoachHeaderView {
    
    // MARK: - Layout
    
    private func setStyle() {
        dateLabel.do {
            $0.font = .korailTitle(.title3m16)
            $0.backgroundColor = .korailBlue(.blue07)
            $0.textAlignment = .center
        }
        
        departureLabel.do {
            $0.font = .korailHead(.head5m20)
            $0.textAlignment = .center
        }
        
        arrowImageView.do {
            $0.image = .icnArrowCircle.withRenderingMode(.alwaysOriginal)
        }
        
        arrivalLabel.do {
            $0.font = .korailHead(.head5m20)
            $0.textAlignment = .center
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(
            dateLabel,
            departureLabel,
            arrowImageView,
            arrivalLabel
        )
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
    
        arrowImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(23)
            $0.size.equalTo(26)
            $0.centerX.equalToSuperview()
        }
        
        departureLabel.snp.makeConstraints {
            $0.centerY.equalTo(arrowImageView)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-26)
            $0.width.equalTo(109)
            $0.height.equalTo(26)
        }
        
        arrivalLabel.snp.makeConstraints {
            $0.centerY.equalTo(arrowImageView)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(26)
            $0.width.equalTo(109)
            $0.height.equalTo(26)
        }
    }
    
    // MARK: - Func
    
    func updateDate(_ date: String) {
        dateLabel.text = date
    }
    
    func updateRoute(departure: String, arrival: String) {
        departureLabel.text = departure
        arrivalLabel.text = arrival
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    let view = CoachHeaderView()
    view.updateDate("2024.11.16 (토)")
    view.updateRoute(departure: "서울", arrival: "부산")
    
    return view.toPreview()
}

#endif
