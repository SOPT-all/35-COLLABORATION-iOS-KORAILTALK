//
//  TrainCheckView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/27/24.
//

import UIKit

import SnapKit
import Then

class TrainCheckView: UIView {

    // MARK: - UI Properties
    
    private let containerView = UIView()
    private let contentView = UIView()
    private let dateLabel = UILabel()
    private let trainNameView = UIView()
    private let trainNameLabel = UILabel()
    private let departurePlaceLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let arrivalPlaceLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let dividerView = UIView()
    private let ticketTypeLabel = UILabel()
    private let passengerCountLabel = UILabel()
    private let seatLabel = UILabel()
    private let seatNumberLabel = UILabel()
    private let fareLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let purpleView = UIView()
    private let paymentDeadlineLabel = UILabel()
    private let grayView = UIView()
    private let cautionLabel = UILabel()
    
    // MARK: - Initializer
    
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

extension TrainCheckView {
    
    // MARK: - Layout
    
    private func setStyle() {
        self.backgroundColor = .korailGrayscale(.gray100)
        
        containerView.do {
            $0.backgroundColor = .korailBlue(.blue03)
            $0.makeCornerRadius(cornerRadius: 12)
        }
        
        contentView.do {
            $0.backgroundColor = .korailBasic(.white)
        }
        
        dateLabel.do {
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailBasic(.white)
        }
        
        trainNameView.do {
            $0.backgroundColor = .korailBlue(.blue02)
            $0.makeCornerRadius(cornerRadius: 10)
        }
        
        trainNameLabel.do {
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailBasic(.white)
        }
        
        departurePlaceLabel.do {
            $0.font = .korailHead(.head4m22)
            $0.textColor = .korailBasic(.black)
        }
        
        [departurePlaceLabel, arrivalPlaceLabel].forEach {
            $0.font = .korailHead(.head4m22)
            $0.textColor = .korailBasic(.black)
            $0.textAlignment = .center
        }
        
        [departureTimeLabel, arrivalTimeLabel].forEach {
            $0.font = .korailBody(.body3r14)
            $0.textColor = .korailGrayscale(.gray600)
            $0.textAlignment = .center
        }
        
        arrowImageView.do {
            $0.image = .icnArrowCircle.withRenderingMode(.alwaysOriginal)
        }
        
        dividerView.do {
            $0.backgroundColor = .korailGrayscale(.gray300)
        }
        
        ticketTypeLabel.do {
            $0.configureWithImage(
                text: "승차권",
                font: .korailBody(.body1sb14),
                textColor: .korailGrayscale(.gray700),
                image: .icnTraincheckPassenger.withRenderingMode(.alwaysOriginal)
            )
        }
        
        seatLabel.do {
            $0.configureWithImage(
                text: "좌석",
                font: .korailBody(.body1sb14),
                textColor: .korailGrayscale(.gray700),
                image: .icnTraincheckSeat.withRenderingMode(.alwaysOriginal)
            )
        }
        
        fareLabel.do {
            $0.configureWithImage(
                text: "운임가격",
                font: .korailBody(.body1sb14),
                textColor: .korailGrayscale(.gray700),
                image: .icnMoney.withRenderingMode(.alwaysOriginal)
            )
        }
        
        [passengerCountLabel, seatNumberLabel].forEach {
            $0.font = .korailBody(.body1sb14)
            $0.textColor = .korailBasic(.black)
        }
        
        priceLabel.do {
            $0.font = .korailHead(.head5m20)
            $0.textColor = .korailPurple(.purple04)
        }
        
        descriptionLabel.do {
            $0.text = "*특(우등)실은 운임과 요금으로 구성되며 운임만 할인됨"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailBasic(.red)
        }
        
        purpleView.do {
            $0.backgroundColor = .korailPurple(.purple05)
            $0.makeCornerRadius(cornerRadius: 8)
        }
        
        paymentDeadlineLabel.do {
            $0.textColor = .korailPurple(.purple02)
            $0.numberOfLines = 0
        }
        
        grayView.do {
            $0.backgroundColor = .korailGrayscale(.gray50)
            $0.makeCornerRadius(cornerRadius: 12)
        }
        
        cautionLabel.do {
            $0.applyAttributedStyles(
                text: "주의사항\n• 결제하지 않으면 예약이 취소됩니다.\n• 승차권을 발권받은 스마트폰에서만 확인할 수 있습니다.\n• 할인승차권 이용시, 관련 신분증 또는 증명서를 소지하셔야 합니다.",
                styles: [
                    (text: "주의사항", font: .korailCaption(.caption1sb12), color: .korailGrayscale(.gray500), lineSpacing: 8),
                    (text: "• 결제하지 않으면 예약이 취소됩니다.\n• 승차권을 발권받은 스마트폰에서만 확인할 수 있습니다.\n• 할인승차권 이용시, 관련 신분증 또는 증명서를 소지하셔야 합니다.", font: .korailCaption(.caption2m12), color: .korailGrayscale(.gray500), lineSpacing: 6)
                ]
            )
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(
            containerView,
            grayView
        )
        
        containerView.addSubviews(
            dateLabel,
            trainNameView,
            contentView
        )
        
        trainNameView.addSubview(trainNameLabel)
        
        contentView.addSubviews(
            departurePlaceLabel,
            departureTimeLabel,
            arrowImageView,
            arrivalPlaceLabel,
            arrivalTimeLabel,
            dividerView,
            ticketTypeLabel,
            passengerCountLabel,
            seatLabel,
            seatNumberLabel,
            fareLabel,
            priceLabel,
            descriptionLabel,
            purpleView
        )
        
        purpleView.addSubview(paymentDeadlineLabel)
        
        grayView.addSubview(cautionLabel)
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        trainNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(14)
        }
        
        trainNameView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(106)
            $0.height.equalTo(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(34)
            $0.size.equalTo(26)
        }
        
        departurePlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-26)
            $0.width.equalTo(109)
            $0.height.equalTo(26)
        }
        
        departureTimeLabel.snp.makeConstraints {
            $0.top.equalTo(departurePlaceLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-62.5)
            $0.width.equalTo(36)
            $0.height.equalTo(14)
        }
        
        arrivalPlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(26)
            $0.width.equalTo(109)
            $0.height.equalTo(26)
        }
        
        arrivalTimeLabel.snp.makeConstraints {
            $0.top.equalTo(arrivalPlaceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(62.5)
            $0.width.equalTo(36)
            $0.height.equalTo(14)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(arrivalTimeLabel.snp.bottom).offset(23)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
        
        ticketTypeLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(23)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        passengerCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(ticketTypeLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(ticketTypeLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        seatNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(seatLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        fareLabel.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(fareLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(14)
        }
        
        paymentDeadlineLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        purpleView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        cautionLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(14)
        }
        
        grayView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setPaymentDeatlineLabel(time: String) {
        let fullText = "결제기한: \(time)\n10분 이내 미결제시 좌석권이 자동으로 취소됩니다."
        paymentDeadlineLabel.applyAttributedStyles(
            text: fullText,
            styles: [
                (text: "결제기한: \(time)", font: UIFont.korailCaption(.caption1sb12), color: .korailPurple(.purple02), lineSpacing: 4),
                (text: "10분 이내 미결제시 좌석권이 자동으로 취소됩니다.", font: UIFont.korailCaption(.caption2m12), color: .korailPurple(.purple02), lineSpacing: 4)
            ]
        )
    }
    
    func configure(
        date: String,
        trainName: String,
        departurePlace: String,
        departureTime: String,
        arrivalPlace: String,
        arrivalTime: String,
        passengerCount: String,
        seatNumber: String,
        price: String,
        deadline: String
    ) {
        dateLabel.text = date
        trainNameLabel.text = trainName
        departurePlaceLabel.text = departurePlace
        departureTimeLabel.text = departureTime
        arrivalPlaceLabel.text = arrivalPlace
        arrivalTimeLabel.text = arrivalTime
        passengerCountLabel.text = passengerCount
        seatNumberLabel.text = seatNumber
        priceLabel.text = price
        setPaymentDeatlineLabel(time: deadline)
    }
    
}
