//
//  FontLiterals.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/19/24.
//

import UIKit

enum FontWeight: String {
    case pretendardRegular = "Pretendard-Regular"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardSemiBold = "Pretendard-SemiBold"
}

enum Head {
    case head1m32
    case head2m28
    case head3m26
    case head4m22
    case head5m20
}

enum Title {
    case title1sb18
    case title2m18
    case title3m16
}

enum Body {
    case body1sb14
    case body2m14
    case body3r14
}

enum Caption {
    case caption1sb12
    case caption2m12
    case caption3sb10
    case caption4m10
}

extension UIFont {

    static func pretendardFont(weight: FontWeight, ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: fontSize) else { fatalError("Font not found") }
        return font
    }
    
    static func korailHead(_ style: Head) -> UIFont {
        switch style {
        case .head1m32: return pretendardFont(weight: .pretendardMedium, ofSize: 32)
        case .head2m28: return pretendardFont(weight: .pretendardMedium, ofSize: 28)
        case .head3m26: return pretendardFont(weight: .pretendardMedium, ofSize: 26)
        case .head4m22: return pretendardFont(weight: .pretendardMedium, ofSize: 22)
        case .head5m20: return pretendardFont(weight: .pretendardMedium, ofSize: 20)
        }
    }
    
    static func korailTitle(_ style: Title) -> UIFont {
        switch style {
        case .title1sb18: return pretendardFont(weight: .pretendardSemiBold, ofSize: 18)
        case .title2m18: return pretendardFont(weight: .pretendardMedium, ofSize: 18)
        case .title3m16: return pretendardFont(weight: .pretendardMedium, ofSize: 16)
        }
    }
    
    static func korailBody(_ style: Body) -> UIFont {
        switch style {
        case .body1sb14: return pretendardFont(weight: .pretendardSemiBold, ofSize: 14)
        case .body2m14: return pretendardFont(weight: .pretendardMedium, ofSize: 14)
        case .body3r14: return pretendardFont(weight: .pretendardRegular, ofSize: 14)
        }
    }
    
    static func korailCaption(_ style: Caption) -> UIFont {
        switch style {
        case .caption1sb12: return pretendardFont(weight: .pretendardSemiBold, ofSize: 12)
        case .caption2m12: return pretendardFont(weight: .pretendardMedium, ofSize: 12)
        case .caption3sb10: return pretendardFont(weight: .pretendardSemiBold, ofSize: 10)
        case .caption4m10: return pretendardFont(weight: .pretendardMedium, ofSize: 10)
        }
    }
    
}
