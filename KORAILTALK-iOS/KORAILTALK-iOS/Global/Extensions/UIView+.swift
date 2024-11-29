//
//  UIView+.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/18/24.
//

import UIKit

extension UIView {
    
    /// subview들을 한꺼번에 추가
    /// - Parameter views: 추가할 subview들
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    /// view의 코너를 둥글게 설정
    /// - Parameters:
    ///   - cornerRadius: 코너의 곡률 반경
    ///   - maskedCorners: 둥글게 만들 코너 선택
    func makeCornerRadius(cornerRadius: CGFloat, maskedCorners: CACornerMask? = nil) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        if let maskedCorners {
            layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
        }
    }
    
    /// view에 테두리(border) 추가
    /// - Parameters:
    ///   - width: 두께
    ///   - color: 색깔
    func makeBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// view에 stroke 추가 - 오른쪽만
    /// - Parameters:
    ///   - color: 색깔
    func addStroke(color: UIColor) {
        let strokeLayer = CALayer()
        strokeLayer.frame = CGRect(x: frame.width - 1, y: 0, width: 1, height: frame.height)
        strokeLayer.backgroundColor = color.cgColor
        layer.addSublayer(strokeLayer)
    }
    
    func formatNumberWithComma(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}
