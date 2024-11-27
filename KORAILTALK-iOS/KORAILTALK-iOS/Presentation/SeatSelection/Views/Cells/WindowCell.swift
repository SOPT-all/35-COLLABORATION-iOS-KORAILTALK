//
//  WindowCell.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class WindowCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let windowView = UIView()
    
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

extension WindowCell {
    
    // MARK: - Layout
    
    private func setStyle() {
        windowView.do {
            $0.backgroundColor = .korailBlue(.blue06)
            $0.makeCornerRadius(cornerRadius: 4)
        }
    }
    
    private func setHierarchy() {
        self.addSubview(windowView)
    }
    
    private func setLayout() {
        windowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
