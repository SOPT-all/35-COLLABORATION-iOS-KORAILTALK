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
        
        rootView.discountSectionView.couponDetailView.veteranDiscountButton.addTarget(self, action: #selector(veteranDiscountButtonTapped), for: .touchUpInside)
        rootView.discountSectionView.pointDetailView.lPointButton.addTarget(self, action: #selector(lpointButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc
    
    @objc private func radioButtonTapped(_ sender: UIButton) {
        rootView.discountSectionView.toggleDropDownState(sender: sender)
    }
    
    @objc private func applyAllAmountButtonTapped() {
        rootView.discountSectionView.mileageDetailView.applyAllAmount()
    }
    
    @objc private func toolbarButtonTapped() {
        rootView.endEditing(true)
        print("입력 완료!!!!!!!!!")
    }
    
    @objc private func veteranDiscountButtonTapped() {
        let veteranDiscountViewController = VeteranDiscountViewController()
        veteranDiscountViewController.delegate = self
        if let sheet = veteranDiscountViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in 234 }]
        }
        self.present(veteranDiscountViewController, animated: true)

    }
    
    @objc private func lpointButtonTapped() {
        let lPointModalViewController = LPointModalViewController()
        lPointModalViewController.delegate = self
        if let sheet = lPointModalViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in 248 }]
        }
        self.present(lPointModalViewController, animated: true)

    }
}

extension PaymentViewController: DiscountDelegate {
    func applyDiscount() {
        rootView.discountSectionView.couponDetailView.applyVeteranDiscount(true)
    }
}

extension PaymentViewController: PointDelegate {
    func applyPoint(pointText: String) {
        rootView.discountSectionView.pointDetailView.changeLPointButtonState(isApplied: true, pointText: pointText)
    }
}
