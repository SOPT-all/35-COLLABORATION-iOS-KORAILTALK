//
//  PaymentView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

import SnapKit
import Then

final class PaymentView: UIView {

    //MARK: - UI Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let ticketSectionView = TicketSectionView()
    private let discountSectionView = DiscountSectionView()
        
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaymentView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailGrayscale(.gray100)
    }
    
    private func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(ticketSectionView, discountSectionView)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.high)
        }
        
        ticketSectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(86)
        }
        
        discountSectionView.snp.makeConstraints {
            $0.top.equalTo(ticketSectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
