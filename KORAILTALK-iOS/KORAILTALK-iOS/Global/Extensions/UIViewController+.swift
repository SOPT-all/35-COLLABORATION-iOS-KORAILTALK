//
//  UIViewController+.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/19/24.
//

import UIKit

extension UIViewController {
    
    func setCustomBackButton() {
        navigationItem.hidesBackButton = true
        
        let backButtonTapped = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        let backBarButton = UIButton(type: .system).then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            $0.addAction(backButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(44)
            }
        }
        
        let leftStackView = UIStackView(arrangedSubviews: [backBarButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: leftStackView)
        navigationItem.leftBarButtonItem = customBarView
    }
    
}
