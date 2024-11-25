//
//  CoachBackgroundView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

class CoachBackgroundView: UICollectionReusableView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .korailGrayscale(.gray100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
