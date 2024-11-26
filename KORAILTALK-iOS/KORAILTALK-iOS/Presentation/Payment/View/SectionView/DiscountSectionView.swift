//
//  DiscountSectionView.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/21/24.
//

import UIKit

import SnapKit
import Then

final class DiscountSectionView: UIView {

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    let mileageRadioButton = KorailRadioButton(buttonType: .ktxMileage)
    let couponRadioButton = KorailRadioButton(buttonType: .discountCoupon)
    let pointRadioButton = KorailRadioButton(buttonType: .pointUsage)
    lazy var mileageDetailView = KTXMileageView()
    private lazy var couponDetailView = DiscountCouponView()
    private lazy var pointDetailView = PointUsageView()
    private let mileageStackView = UIStackView()
    private let couponStackView = UIStackView()
    private let pointStackView = UIStackView()

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

extension DiscountSectionView {
    
    // MARK: - Layout
    
    private func setStyle() {
        backgroundColor = .korailBasic(.white)
        
        titleLabel.do {
            $0.text = "할인"
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
            $0.font = .korailTitle(.title1sb18)
        }
        
        [mileageStackView, couponStackView, pointStackView].forEach { stackView in
            stackView.backgroundColor = .clear
            stackView.axis = .vertical
            stackView.spacing = 12
            stackView.alignment = .leading
            stackView.distribution = .equalSpacing
        }
        
        [mileageDetailView, couponDetailView, pointDetailView].forEach { view in
            view.isHidden = true
        }
    }
    
    private func setHierarchy() {
        addSubviews(titleLabel, mileageStackView, couponStackView, pointStackView)
        mileageStackView.addArrangedSubviews(mileageRadioButton, mileageDetailView)
        couponStackView.addArrangedSubviews(couponRadioButton, couponDetailView)
        pointStackView.addArrangedSubviews(pointRadioButton, pointDetailView)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        [mileageRadioButton, couponRadioButton, pointRadioButton].forEach { button in
            button.snp.makeConstraints {
                $0.height.equalTo(28)
            }
        }
        
        mileageStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        mileageDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        couponStackView.snp.makeConstraints {
            $0.top.equalTo(mileageStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        couponDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        
        pointStackView.snp.makeConstraints {
            $0.top.equalTo(couponStackView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        pointDetailView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    //MARK: - Func
    
    func toggleDropDownState(sender: UIButton) {
        switch sender {
        case mileageRadioButton:
            mileageRadioButton.isSelected.toggle()
            mileageDetailView.isHidden = !mileageRadioButton.isSelected
            
            couponRadioButton.isSelected = false
            couponDetailView.isHidden = true
            pointRadioButton.isSelected = false
            pointDetailView.isHidden = true
        case couponRadioButton:
            couponRadioButton.isSelected.toggle()
            couponDetailView.isHidden = !couponRadioButton.isSelected

            mileageRadioButton.isSelected = false
            mileageDetailView.isHidden = true
            pointRadioButton.isSelected = false
            pointDetailView.isHidden = true
        case pointRadioButton:
            pointRadioButton.isSelected.toggle()
            pointDetailView.isHidden = !pointRadioButton.isSelected

            couponRadioButton.isSelected = false
            couponDetailView.isHidden = true
            mileageRadioButton.isSelected = false
            mileageDetailView.isHidden = true
        default:
            return
        }
    }
}
