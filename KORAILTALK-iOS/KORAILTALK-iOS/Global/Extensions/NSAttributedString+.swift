//
//  NSAttributedString+.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

extension NSAttributedString {
    
    /**
     NSAttributedString을 생성하는 유틸리티 함수
     
     - Parameters:
     - text: 표시할 문자열
     - color: 텍스트 색상
     - font: 적용할 폰트
     - lineSpacing: 줄 간 간격(포인트 단위)
     - textAlignment: 텍스트 정렬 방식 (기본값: .left)
     - lineBreakMode: 줄 바꿈 방식 (기본값: .byWordWrapping)
     - lineHeightMultiple: 텍스트의 줄 간격 배수 (기본값: 1.0)
     
     - Returns: 설정된 속성을 가진 NSAttributedString
     */
    static func makeAttributedString(text: String,
                                     color: UIColor,
                                     font: UIFont,
                                     lineSpacing: CGFloat = 0,
                                     paragraphSeparator: CGFloat = 0,
                                     textAlignment: NSTextAlignment = .left,
                                     lineBreakMode: NSLineBreakMode = .byWordWrapping,
                                     lineHeightMultiple: CGFloat = 1.0) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSeparator
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        return attributedString
    }
    
}
