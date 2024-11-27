//
//  LPointResponseDTO.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/28/24.
//

import Foundation

struct LPointResponseDTO: Codable {
    let data: LPointData
}

struct LPointData: Codable {
    let isValid: Bool
    let point: Int
}
