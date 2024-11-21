//
//  FilterDelegate.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/20/24.
//

import Foundation

protocol FilterDelegate: AnyObject {
    
    func showBottomSheet(
        title: String,
        bottomType: BottomType,
        listType: [String]
    )
    
    func showDateCollectionView()
    
}
