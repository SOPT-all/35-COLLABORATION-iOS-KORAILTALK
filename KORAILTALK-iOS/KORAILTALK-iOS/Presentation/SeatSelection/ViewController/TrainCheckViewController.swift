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
    
    private let ticketsService = NetworkService.shared.ticketsService
    
    // MARK: - UI Properties
    private let trainCheckView = TrainCheckView()
    private let paymentActionsView = PaymentActionsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTicketData()
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
    
    private func loadTicketData() {
        guard let ticketId = UserDefaultsManager.shared.getTicketId() else { return }
        
        ticketsService.getMyTicket(ticketId: ticketId) { [weak self] response in
            switch response {
            case .success(let data):
                DispatchQueue.main.async {
                    if let ticket = data?.data {
                        UserDefaultsManager.shared.saveTicketPrice(ticket.ticketPrice)
                        print("UserDefault Save - Price: \(ticket.ticketPrice) ")
                        self?.trainCheckView.configure(
                            date: ticket.date,
                            trainName: ticket.trainName,
                            departurePlace: ticket.departurePlace,
                            departureTime: ticket.departureTime,
                            arrivalPlace: ticket.arrivalPlace,
                            arrivalTime: ticket.arrivalTime,
                            passengerCount: "어른 1명",
                            seatNumber: ticket.seatName,
                            price: "\(ticket.ticketPrice)원",
                            deadline: ticket.limitPaymentTime
                        )
                    }
                }
            default:
                break
            }
        }
    }
    
}

extension TrainCheckViewController: PaymentActionsViewDelegate {
    
    func saveButtonTapped() {
        print("담아두기 Tapped")
    }
    
    func payButtonTapped() {
        print("바로결제 Tapped")
        let popupVC = TrainCheckPopupViewController()
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true)
    }
    
}

extension TrainCheckViewController: TrainCheckPopupDelegate {
    func didTapConfirmButton() {
        let paymentVC = PaymentViewController()
        navigationController?.pushViewController(paymentVC, animated: true)
    }
}
