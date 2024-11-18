//
//  ColorLiterals.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/19/24.
//

import UIKit

enum Basic: String {
    case white = "#FFFFFF"
    case black = "#000000"
    case red = "#FF4343"
}

enum Blue: String {
    case blue01 = "#063B62"
    case blue02 = "#035795"
    case blue03 = "#0B6CB6"
    case blue04 = "#3284C2"
    case blue05 = "#68A7D5"
    case blue06 = "#C1E1FA"
    case blue07 = "#EBF6FF"
}

enum Purple: String {
    case purple01 = "#47346C"
    case purple02 = "#673BB7"
    case purple03 = "#7D43E8"
    case purple04 = "#9747FF"
    case purple05 = "#F5EDFF"
}

enum Grayscale: String {
    case gray25 = "#FCFCFD"
    case gray50 = "#F9FAFB"
    case gray100 = "#F3F4F6"
    case gray200 = "#E5E7EB"
    case gray300 = "#D2D6DB"
    case gray400 = "#9DA4AE"
    case gray500 = "#6C737F"
    case gray600 = "#4D5761"
    case gray700 = "#384250"
    case gray800 = "#1F2A37"
    case gray900 = "#111927"
    case gray950 = "#0D121C"
}

enum Transparent: String {
    case white10 = "#FFFFFF1A"
    case blue50 = "#94BFDF80"
    case blue95 = "#253A4AF2"
    case black50 = "#000000B2"
}

extension UIColor {
    static func korailBasic(_ style: Basic) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func korailBlue(_ style: Blue) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func korailPurple(_ style: Purple) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func korailGrayscale(_ style: Grayscale) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func korailTransparent(_ style: Transparent) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
}

extension UIColor {
    
    convenience init?(hexCode: String) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        guard let validHexCodeCount = hexFormatted.getValidHexDigits() else {
            fatalError("Invalid hex code: \(hexFormatted)")
        }
        
        var rgbValue: UInt64 = 0
        var alpha: UInt64 = 255
        if validHexCodeCount == 6 {
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        } else if validHexCodeCount == 8 {
            Scanner(string: String(hexFormatted.prefix(6))).scanHexInt64(&rgbValue)
            Scanner(string: String(hexFormatted.suffix(2))).scanHexInt64(&alpha)
        }
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat((alpha & 0xFF)) / 255.0)
    }
    
}
