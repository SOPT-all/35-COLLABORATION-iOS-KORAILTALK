//
//  UILabel+.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/18/24.
//

import UIKit

extension UILabel {
    
    /// 특정 text의 속성(폰트, 색상)을 바꿔주는 함수
    /// - Parameter targetText: 변경할 String 값
    /// - Parameter font: 적용할 font
    /// - Parameter color: 적용할 color
    /// > 사용 예시 : `label.highlightText(targetText: nicknameString, font: .offroad(style: .iosSubtitle2Bold))`
    func highlightText(targetText: String, font: UIFont? = nil, color: UIColor? = nil) {
        guard let labelText = self.text else { return }
        guard let attributedText else { return }
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        let range = (labelText as NSString).range(of: targetText)
        
        if let font {
            attributedString.addAttribute(.font, value: font, range: range)
        }
        
        if let color {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        self.attributedText = attributedString
    }
    
    /**
    텍스트와 이미지를 함께 표시하는 UILabel 설정 함수
    - Parameters:
        - text: 라벨에 표시할 텍스트
        - font: 텍스트에 적용할 폰트
        - textColor: 텍스트에 적용할 색상
        - image: 텍스트 앞에 표시할 이미지 (옵션)
        - imageFrame: 이미지의 크기와 위치를 지정하는 `CGRect` (기본값: `CGRect(x: 0, y: -2, width: 17, height: 17)`)
        - spacing: 이미지와 텍스트 사이의 간격 (기본값: `4`)
    
     > 사용 예시:
      `label.configureWithImage(text: "아이콘 텍스트", font: .systemFont(ofSize: 14), textColor: .black, image: UIImage(systemName: "star.fill"))`
    */
    func configureWithImage(
        text: String,
        font: UIFont,
        textColor: UIColor,
        image: UIImage?,
        imageFrame: CGRect = CGRect(x: 0, y: -5, width: 17, height: 17),
        spacing: CGFloat = 0.5
    ) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = imageFrame
        
        let attributedString = NSMutableAttributedString()
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        let spacingString = NSAttributedString(
            string: " ",
            attributes: [.kern: spacing]
        )

        let textString = NSAttributedString(string: text, attributes: textAttributes)
        
        attributedString.append(imageString)
        attributedString.append(spacingString)
        attributedString.append(textString)
        
        self.attributedText = attributedString
    }
    
    func applyAttributedStyles(
        text: String,
        styles: [(text: String, font: UIFont, color: UIColor, lineSpacing: CGFloat)]
    ) {
        let attributedString = NSMutableAttributedString(string: text)
       
        styles.forEach { style in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = style.lineSpacing
            
            if let range = text.range(of: style.text) {
                let nsRange = NSRange(range, in: text)
                attributedString.addAttributes([
                    .font: style.font,
                    .foregroundColor: style.color,
                    .paragraphStyle: paragraphStyle
                ], range: nsRange)
            }
        }
        
        self.attributedText = attributedString
        self.numberOfLines = 0
    }
    
    func applyUniformStyleWithLineSpacing(
        text: String,
        font: UIFont,
        color: UIColor,
        styles: [(text: String, lineSpacing: CGFloat)]
    ) {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: color
        ])
        
        styles.forEach { style in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = style.lineSpacing
            
            if let range = text.range(of: style.text) {
                let nsRange = NSRange(range, in: text)
                attributedString.addAttributes([
                    .paragraphStyle: paragraphStyle
                ], range: nsRange)
            }
        }
        
        self.attributedText = attributedString
        self.numberOfLines = 0
    }
    
}
