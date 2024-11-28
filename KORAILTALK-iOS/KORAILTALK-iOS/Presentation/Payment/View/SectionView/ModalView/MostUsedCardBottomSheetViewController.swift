//
//  CardTypeBottomSheetViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/28/24.
//

import UIKit

protocol SelectCardDelegate: AnyObject {
    func didSelectHyundaiCard(_ bool: Bool)
}

final class MostUsedCardBottomSheetViewController: SelectBottomSheetViewController {
    
    //MARK: - Properties
    
    weak var delegate: SelectCardDelegate?
    
    let listType = ["직접입력", "내 현대카드"]
    
    // MARK: - Life Cycle
    
    init() {
        super.init(title: "자주쓰는 카드", bottomType: .purple, listType: ["직접입력", "내 현대카드"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - override Func
    
    @objc override func hideBottomSheet() {
        let bool = listType[selectedIndex] == "내 현대카드"
        delegate?.didSelectHyundaiCard(bool)
        
        super.hideBottomSheet()
    }
}
