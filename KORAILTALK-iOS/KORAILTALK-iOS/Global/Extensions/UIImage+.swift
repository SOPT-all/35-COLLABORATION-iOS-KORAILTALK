//
//  UIImage+.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

extension UIImage {
    
    /// 이미지 리사이즈
    ///
    /// > 사용 예시 :
    /// if let resizedImage = UIImage(resource: 이미지이름)
    /// .resized(CGSize(width: 18, height: 18)) {
    ///  이미지 사용
    /// } else { return }

    func resized(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
