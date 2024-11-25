//
//  PaymentViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = PaymentView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
}

extension PaymentViewController {
    
    // MARK: - Private Func
    
    private func setNavigationBar() {
        self.title = "결제하기"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .korailPurple(.purple02)
        appearance.titleTextAttributes = [
            .font: UIFont.korailTitle(.title1sb18),
            .foregroundColor: UIColor.korailBasic(.white)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.setCustomBackButton()
        
        let xButton = UIButton(type: .system).then {
            $0.setImage(.icnX.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: xButton)
    }
    
    private func setAddTarget() {
        rootView.discountSectionView.mileageRadioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        rootView.discountSectionView.couponRadioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        rootView.discountSectionView.pointRadioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        rootView.discountSectionView.mileageDetailView.applyAllAmountButton.addTarget(self, action: #selector(applyAllAmountButtonTapped), for: .touchUpInside)
        rootView.discountSectionView.mileageDetailView.toolBarButton.addTarget(self, action: #selector(toolbarButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc
    
    @objc private func radioButtonTapped(_ sender: UIButton) {
        rootView.discountSectionView.toggleDropDownState(sender: sender)
    }
    
    @objc private func applyAllAmountButtonTapped() {
        rootView.discountSectionView.mileageDetailView.applyAllAmount()
    }
    
    @objc private func toolbarButtonTapped() {
        print("입력 완료!!!!!!!!!")
    }
}
