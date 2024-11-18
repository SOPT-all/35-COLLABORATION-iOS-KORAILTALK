//
//  SeatSelectionViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

import SnapKit
import Then

class SeatSelectionViewController: UIViewController {

    // MARK: - UI Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.view.backgroundColor = .red
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.subviews.forEach {
            if $0 is UIStackView {
                $0.removeFromSuperview()
            }
        }
    }

}

extension SeatSelectionViewController {
    
    // MARK: - Layout
    private func setNavigationBar() {
        self.title = "좌석 선택"
        
        self.setCustomBackButton()
        
        let reloadButtonTapped = UIAction { [weak self] _ in
            // TODO: 새로고침
            print("reloadButtonTapped")
        }
        let reloadButton = UIButton(type: .system).then {
            $0.setImage(UIImage(systemName: "person.bust.circle"), for: .normal)
            $0.addAction(reloadButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let menuButtonTapped = UIAction { [weak self] _ in
            // TODO: 메뉴버튼
            print("menuButtonTapped")
        }
        let menuButton = UIButton(type: .system).then {
            $0.setImage(UIImage(systemName: "person.bust.circle"), for: .normal)
            $0.addAction(menuButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let rightStackView = UIStackView(arrangedSubviews: [reloadButton, menuButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: rightStackView)
        navigationItem.rightBarButtonItem = customBarView
        
    }
    // MARK: - Private Func
    
    // MARK: - Func
}

