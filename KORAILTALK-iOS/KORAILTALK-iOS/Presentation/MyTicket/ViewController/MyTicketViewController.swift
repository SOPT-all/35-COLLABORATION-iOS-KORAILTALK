//
//  MyTicketViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/26/24.
//

import UIKit

final class MyTicketViewController: UIViewController {
    
    private let rootView = MyTicketView()
    private var ticketId: Int = 1
    
    init(ticketId: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.ticketId = ticketId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMyTicket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
        rootView.toast()
    }
    
    private func setNavigationBar() {
        self.title = "나의 티켓"
        let menuButtonTapped = UIAction { [weak self] _ in
            // TODO: 메뉴버튼
            print("menuButtonTapped")
        }
        let menuButton = UIButton(type: .system).then {
            $0.setImage(.icnMenu.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(menuButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let rightStackView = UIStackView(arrangedSubviews: [menuButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: rightStackView)
        navigationItem.rightBarButtonItem = customBarView
        
       
        
    }
     
}

extension MyTicketViewController {
    private func loadMyTicket() {
    
        NetworkService.shared.ticketsService.getMyTicket(ticketId: ticketId) { [weak self] response in
            switch response {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.rootView.bindData(ticket: data?.data)
                }
            default:
                break
            }
        }
        
    }
}

