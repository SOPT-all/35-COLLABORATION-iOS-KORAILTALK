//
//  TrainCheckViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/27/24.
//

import UIKit

import SnapKit
import Then

class TrainCheckViewController: UIViewController {
    
    // MARK: - UI Properties
    private let trainCheckView = TrainCheckView()
    private let paymentActionsView = PaymentActionsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainCheckView.configure(
            date: "2024년 10월 30일",
            trainName: "KTX 001",
            departurePlace: "서울",
            departureTime: "19:54",
            arrivalPlace: "부산",
            arrivalTime: "18:32",
            passengerCount: "어른 1명",
            seatNumber: "7호차 16A",
            price: "12,500원",
            deadline: "16시 01분"
        )

        view.backgroundColor = .korailGrayscale(.gray100)
        sethierarchy()
        setLayout()
        setDelegate()
        setNavigationBar()
    }

}

extension TrainCheckViewController {
    
    private func setNavigationBar() {
        self.title = "승차권 정보 확인"
        
        self.setCustomBackButton()
        
        let xButtonTapped = UIAction { [weak self] _ in
            // TODO: X버튼
            print("xButtonTapped")
        }
        let xButton = UIButton(type: .system).then {
            $0.setImage(.icnX.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(xButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let rightStackView = UIStackView(arrangedSubviews: [xButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: rightStackView)
        navigationItem.rightBarButtonItem = customBarView
    }
    
    private func sethierarchy() {
        self.view.addSubviews(
            trainCheckView,
            paymentActionsView
        )
    }
    
    private func setLayout() {
        trainCheckView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        paymentActionsView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(102)
        }
    }
    
    private func setDelegate() {
        paymentActionsView.delegate = self
    }
    
}

extension TrainCheckViewController: PaymentActionsViewDelegate {
    
    func saveButtonTapped() {
        print("담아두기 Tapped")
    }
    
    func payButtonTapped() {
        print("바로결제 Tapped")
        let popupVC = TrainCheckPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true)
    }
    
}
