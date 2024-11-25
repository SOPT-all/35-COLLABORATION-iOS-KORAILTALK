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
        - textAlignment: 텍스트 정렬 방식 (기본값: `.left`)
        - lineBreakMode: 줄 바꿈 방식 (기본값: `.byCharWrapping`)
        - lineBreakStrategy: 줄 바꿈 전략 (기본값: `.hangulWordPriority`)
        - lineHeightMultiple: 텍스트의 줄 간격 배수 (기본값: `1.0`)

     - Returns: 설정된 속성을 가진 AttributedString

     ```swift
     let attributedString = NSAttributedString.makeAttributedString(
         text: "샘플 텍스트",
         color: .black,
         font: UIFont.systemFont(ofSize: 14),
         textAlignment: .center,
         lineBreakMode: .byWordWrapping,
         lineHeightMultiple: 1.2
     )
     */
    static func makeAttributedString(text: String,
                                     color: UIColor,
                                     font: UIFont,
                                     textAlignment: NSTextAlignment = .left,
                                     lineBreakMode: NSLineBreakMode = .byClipping,
                                     lineBreakStrategy: NSParagraphStyle.LineBreakStrategy = .hangulWordPriority,
                                     lineHeightMultiple: CGFloat = 1.0) -> AttributedString {
        // 문단 스타일
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineBreakStrategy = lineBreakStrategy
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        // 폰트 속성
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        let nsAttributedString = NSAttributedString(string: text, attributes: attributes)
        
        return AttributedString(nsAttributedString)
    }
    
}
