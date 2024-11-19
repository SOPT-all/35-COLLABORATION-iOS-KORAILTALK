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
    
    private let trainSearchFilterView = TrainSearchFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(trainSearchFilterView)
        
        trainSearchFilterView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
