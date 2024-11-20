//
//  TrainSearchViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

final class TrainSearchViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private let trainSearchFilterView = TrainSearchFilterView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setStyle()
        setHierachy()
        setLayout()
        
    }
    
    private func setStyle() {
        trainSearchFilterView.do {
            $0.delegate = self
        }
    }
    
    private func setHierachy() {
        view.addSubview(trainSearchFilterView)
    }
    
    private func setLayout() {
        trainSearchFilterView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TrainSearchViewController: FilterDelegate {
    
    func showBottomSheet(title: String, bottomType: BottomType, listType: [String]) {
        
        let viewController = SelectBottomSheetViewController(
            title: title,
            bottomType: bottomType,
            listType: listType
        )
        self.present(viewController, animated: false)
        
    }
    
}
