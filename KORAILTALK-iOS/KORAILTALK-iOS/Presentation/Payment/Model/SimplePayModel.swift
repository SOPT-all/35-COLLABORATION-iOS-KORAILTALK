//
//  SimplePayModel.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

struct SimplePayModel{
    let title: String
    let includeEvent: Bool
}

extension SimplePayModel {
    static func dummy() -> [SimplePayModel] {
        [SimplePayModel(title: "레일 플러스카드", includeEvent: false),
         SimplePayModel(title: "네이버페이 (머니)", includeEvent: true),
         SimplePayModel(title: "제로페이카드", includeEvent: false),
         SimplePayModel(title: "네이버페이 (카드)", includeEvent: false),
         SimplePayModel(title: "KB Pay", includeEvent: false),
         SimplePayModel(title: "토스페이", includeEvent: false),
         SimplePayModel(title: "카카오페이", includeEvent: false),
         SimplePayModel(title: "신한SOL페이", includeEvent: false),
         SimplePayModel(title: "PAYCO", includeEvent: false),
         SimplePayModel(title: "BC페이북", includeEvent: false)
        ]
    }
}
