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
            $0.setImage(.icnArrowLeft.withRenderingMode(.alwaysOriginal), for: .normal)
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
    
    ///키보드 제외한 부분을 탭했을 때 키보드가 내려가는 함수
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIViewController: UIGestureRecognizerDelegate {
    
    ///특정 뷰(UIButton)에서 터치 동작을 무시하도록 설정
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton {
            return false
        }
        return true
    }
}
