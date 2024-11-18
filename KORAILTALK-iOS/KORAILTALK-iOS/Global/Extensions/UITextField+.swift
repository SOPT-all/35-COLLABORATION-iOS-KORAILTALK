//
//  UITextField+.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/18/24.
//

import UIKit

extension UITextField {
    
    /// UITextField에 좌우 여백(padding) 추가
    /// - Parameters:
    ///   - left: 왼쪽 여백
    ///   - right: 오른쪽 여백
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
            leftViewMode = .always
        }
        if let right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
            rightViewMode = .always
        }
    }
    
    /// UITextField placeholder 설정
    /// - Parameters:
    ///   - placeholder: placeholder 내용
    ///   - fontColor: placeholder 색상
    ///   - font: placeholder 폰트
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor: fontColor!,
                                                                     .font: font])
    }
    
    /// UITextField font 설정
    /// - Parameters:
    ///   - font: 입력 텍스트 font
    ///   - fontColor: 입력 텍스트 색상
    func setTextFont(font: UIFont, fontColor: UIColor) {
        self.font = font
        self.textColor = fontColor
    }
    
}
