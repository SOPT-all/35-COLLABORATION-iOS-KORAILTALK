//
//  BasePopupView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/26/24.
//

import UIKit

import SnapKit
import Then

class BasePopupViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    let contentView = UIView()
    private let confirmButton = UIButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHierarchy()
        setLayout()
        setAction()
    }
    
}

extension BasePopupViewController {
    
    // MARK: - Layout
    
    private func setStyle() {
        view.backgroundColor = .korailTransparent(.black50)
        
        containerView.backgroundColor = .korailBlue(.blue07)
        containerView.makeCornerRadius(cornerRadius: 12)
        
        contentView.backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.font = .korailBody(.body1sb14)
            $0.textColor = .korailBlue(.blue01)
        }
        
        confirmButton.do {
            $0.backgroundColor = .korailBlue(.blue03)
            $0.setTitle("확인 완료", for: .normal)
            $0.setTitleColor(.korailBasic(.white), for: .normal)
            $0.titleLabel?.font = .korailTitle(.title3m16)
        }
    }
    
    private func setHierarchy() {
        view.addSubview(containerView)
        containerView.addSubviews(
            titleLabel,
            contentView,
            confirmButton
        )
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setAction() {
        let confirmButtonTapped = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        confirmButton.addAction(confirmButtonTapped, for: .touchUpInside)
    }
    
    // MARK: - Func
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
}
