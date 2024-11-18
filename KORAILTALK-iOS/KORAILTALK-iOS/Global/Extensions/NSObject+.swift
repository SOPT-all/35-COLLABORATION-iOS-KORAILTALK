//
//  NSObject+.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/18/24.
//

import Foundation


extension NSObject {
    
    /// 클래스의 이름
    static var className: String {
        return String(describing: self)
    }
    
}
