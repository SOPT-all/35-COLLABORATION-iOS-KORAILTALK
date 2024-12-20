//
//  PaymentViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    //MARK: - Properties
    
    private let simplePayModelList = SimplePayModel.dummy()
    
    private let rootView = PaymentView()
    
    private var ticketPrice = UserDefaultsManager.shared.getTicketPrice()
    private var ticketID = UserDefaultsManager.shared.getTicketId()
    private var discountAmount = 0 {
        didSet {
            rootView.updatePaymentInfo(discountAmount: discountAmount)
        }
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.setTicketPrice(price: ticketPrice)
        hideKeyboard()
        setAddTarget()
        setCollectionView()
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
        [rootView.discountSectionView.mileageRadioButton, rootView.discountSectionView.couponRadioButton, rootView.discountSectionView.pointRadioButton].forEach { button in
            button.addTarget(self, action: #selector(discountSectionRadioButtonTapped(_:)), for: .touchUpInside)
        }
        rootView.discountSectionView.mileageDetailView.applyAllAmountButton.addTarget(self, action: #selector(applyAllAmountButtonTapped), for: .touchUpInside)
        rootView.discountSectionView.mileageDetailView.toolBarButton.addTarget(self, action: #selector(toolbarButtonTapped), for: .touchUpInside)
        
        rootView.discountSectionView.couponDetailView.veteranDiscountButton.addTarget(self, action: #selector(veteranDiscountButtonTapped), for: .touchUpInside)
        rootView.discountSectionView.pointDetailView.lPointButton.addTarget(self, action: #selector(lpointButtonTapped), for: .touchUpInside)
        
        [rootView.paymentMethodSectionView.simplePayRadioButton, rootView.paymentMethodSectionView.cardPayRadioButton].forEach { button in
            button.addTarget(self, action: #selector(paymentMethodSectionRadioButtonTapped(_:)), for: .touchUpInside)
        }
        [rootView.paymentMethodSectionView.cardPayDetailView.mostUsedCardButton, rootView.paymentMethodSectionView.cardPayDetailView.cardTypeButton, rootView.paymentMethodSectionView.cardPayDetailView.installmentPeriodButton].forEach { button in
            button.addTarget(self, action: #selector(cardPayDetailViewDropDownButtonTapped(_:)), for: .touchUpInside)
        }
        
        rootView.paymentMethodSectionView.cardPayDetailView.checkBoxButton.addTarget(self, action: #selector(cardPayDetailViewCheckBoxButtonTapped), for: .touchUpInside)
        
        rootView.ticketingButton.addTarget(self, action: #selector(ticketingButtonTapped), for: .touchUpInside)
    }
    
    private func setCollectionView() {
        rootView.paymentMethodSectionView.simplePayDetailView.simplePayCollectionView.delegate = self
        rootView.paymentMethodSectionView.simplePayDetailView.simplePayCollectionView.dataSource = self
    }
    
    private func isPossibleTicketing(_ bool: Bool) {
        rootView.ticketingButton.isEnabled = bool
        rootView.ticketingButton.backgroundColor = bool ? .korailPurple(.purple03) : .korailGrayscale(.gray200)
    }
    
    private func patchTicketing(body: TicketsRequestDTO) {
        NetworkService.shared.ticketsService.patchTicketing(body: body) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success:
                print("발권 완료!!!!!!")
            default:
                break
            }
        }
    }
    
    //MARK: - @objc
    
    @objc private func discountSectionRadioButtonTapped(_ sender: UIButton) {
        discountAmount = 0
        rootView.discountSectionView.toggleDropDownState(sender: sender)
    }
    
    @objc private func applyAllAmountButtonTapped() {
        rootView.discountSectionView.mileageDetailView.applyAllAmount()
    }
    
    @objc private func toolbarButtonTapped() {
        let discountAndPointText = rootView.discountSectionView.mileageDetailView.mileageTextField.text ?? ""
        discountAmount = Int(discountAndPointText) ?? 0
        rootView.endEditing(true)
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
    
    @objc private func paymentMethodSectionRadioButtonTapped(_ sender: UIButton) {
        rootView.paymentMethodSectionView.toggleDropDownState(sender: sender)
        isPossibleTicketing(false)
    }
    
    @objc private func cardPayDetailViewDropDownButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let mostUsedCardBottomSheetViewController = MostUsedCardBottomSheetViewController()
            mostUsedCardBottomSheetViewController.delegate = self
            present(mostUsedCardBottomSheetViewController, animated: true)
        case 1:
            let cardTypeBottomSheetViewController = SelectBottomSheetViewController(title: "카드종류", bottomType: .purple, listType: ["개인", "법인"])
            present(cardTypeBottomSheetViewController, animated: true)
        case 2:
            let installmentPeriodBottomSheetViewController = SelectBottomSheetViewController(title: "할부기간", bottomType: .purple, listType: ["일시불", "3개월", "6개월"])
            present(installmentPeriodBottomSheetViewController, animated: true)
        default:
            return
        }
    }
    
    @objc private func cardPayDetailViewCheckBoxButtonTapped() {
        rootView.paymentMethodSectionView.cardPayDetailView.checkBoxButton.isSelected.toggle()
        rootView.paymentMethodSectionView.cardPayDetailView.checkBoxButton.isSelected ? isPossibleTicketing(true) : isPossibleTicketing(false)
    }
    
    @objc private func ticketingButtonTapped() {
        let ticketID = ticketID ?? 0
        let totalPrice = ticketPrice - discountAmount
        patchTicketing(body: TicketsRequestDTO(ticketId: ticketID, totalPrice: totalPrice, usedPoint: discountAmount))
        
        let viewController = MyTicketViewController(ticketId: ticketID)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension PaymentViewController: DiscountDelegate {
    func applyDiscount() {
        rootView.discountSectionView.couponDetailView.applyVeteranDiscount(true)
        discountAmount = 500
    }
}

extension PaymentViewController: PointDelegate {
    func applyPoint(pointAmount: Int) {
        rootView.discountSectionView.pointDetailView.changeLPointButtonState(isApplied: true, pointText: String(pointAmount))
        discountAmount = pointAmount
    }
}

extension PaymentViewController: SelectCardDelegate {
    func didSelectHyundaiCard(_ bool: Bool) {
        rootView.paymentMethodSectionView.cardPayDetailView.isHyundaiCardSelected(bool)
    }
}

//MARK: - UICollectionViewDataSource

extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return simplePayModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimplePayCollectionViewCell.className, for: indexPath) as? SimplePayCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(data: simplePayModelList[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 40) / 2, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected.toggle()
        isPossibleTicketing(true)
    }
}
