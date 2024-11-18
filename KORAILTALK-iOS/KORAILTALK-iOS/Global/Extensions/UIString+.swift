//
//  UIString+.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/19/24.
//

import Foundation

extension String {
    
    func getValidHexDigits() -> Int? {
        guard let regex = try? NSRegularExpression(pattern: "^([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$") else { return nil }
        let range = NSRange(location: 0, length: self.count)
        let resultLength = regex.rangeOfFirstMatch(in: self, range: range).length
        if resultLength == 6 {
            return 6
        } else if resultLength == 8 {
            return 8
        } else {
            return nil
        }
    }
    
}
