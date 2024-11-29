//
//  MyTicketView.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/26/24.
//

import UIKit

import Lottie

final class MyTicketView: UIView {
    
    //MARK: - UI Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerImageView = UIImageView()
    private let animationView = LottieAnimationView(name: "ios_korail")
    private let navbarImageView = UIImageView()
    
    private let ticketTitleView = UIView()
    private let dateLabel = UILabel()
    private let trainNameView = UIView()
    private let trainNameLabel = UILabel()
    
    private let ticketImageView = UIImageView()
    
    private let trainTimeLocationStackView = UIStackView()
    private let departureStackview = UIStackView()
    private let departureLocationLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let arrivalStackView = UIStackView()
    private let arrivalLocationLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    
    private let infoButton = MyTicketRoundedStrokeButton(title: "열차정보")
    private let btnImageView = UIImageView()
    
    private let firstInfoView = UIView()
    private let firstInfoLabel = UILabel()
    private let reloadImageView = UIImageView()
    private let timeDescriptionLabel = UILabel()
    
    private let secondInfoView = UIView()
    private let secondInfoLabel = UILabel()
    private let trainNumberLabel = UILabel()
    private let trainDescriptionLabel = UILabel()
    
    private let thirdInfoView = UIView()
    private let thirdInfoLabel = UILabel()
    private let seatLabel = UILabel()
    private let windowLabel = UILabel()
    
    private let fourthInfoView = UIView()
    private let fourthInfoLabel = UILabel()
    private let qrImageView = UIImageView()
    
    private let buttonStackView = UIStackView()
    private let passButton = MyTicketBlueButton(title: "승차권 전달")
    private let cancleButton = MyTicketBlueButton(title: "예매 취소")
    private let changeButton = MyTicketBlueButton(title: "예매 변경")
    
    private let serviceView = UIView()
    private let serviceDescriptionLabel = UILabel()
    private let serviceStackView = UIStackView()
    
    private let reportStackView = UIStackView()
    private let reportImageView = UIImageView()
    private let reportLabel = UILabel()
    
    private let helperStackView = UIStackView()
    private let helperImageView = UIImageView()
    private let helperLabel = UILabel()
    
    private let smsStackView = UIStackView()
    private let smsImageView = UIImageView()
    private let smslLabel = UILabel()
    
    private let toastView = UIView()
    private let toastLabel = UILabel()
    
    //MARK: - Properties
    
    private let serviceButton = MyTicketRoundedStrokeButton(title: "부가서비스 더보기")
    private var ticket: Ticket?
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setStyle()
        setHierarchy()
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        
        backgroundColor = .korailGrayscale(.gray100)
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
        }
        
        headerImageView.do {
            $0.image = .cmpMyTicketTabBar
        }
        ticketTitleView.do {
            $0.backgroundColor = .korailBlue(.blue03)
            $0.layer.cornerRadius = 12
        }
        dateLabel.do {
//            $0.text = "2024년 10월 30일 (수)"
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailBasic(.white)
        }
        trainNameView.do {
            $0.backgroundColor = .korailBlue(.blue02)
            $0.makeCornerRadius(cornerRadius: 10)
        }
        trainNameLabel.do {
//            $0.text = "KTX 001"
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailBasic(.white)
        }
        ticketImageView.do {
            $0.image = .imgMyticketBg
        }
        
        trainTimeLocationStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 26
        }
        departureStackview.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 8
        }
        departureLocationLabel.do {
            $0.text = "서울"
            $0.font = .korailHead(.head3m26)
        }
        departureTimeLabel.do {
//            $0.text = "19:54"
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailGrayscale(.gray600)
        }
        arrowImageView.do {
            $0.image = .icnArrowCircle
        }
        arrivalStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 8
        }
        arrivalLocationLabel.do {
            $0.text = "부산"
            $0.font = .korailHead(.head3m26)
        }
        arrivalTimeLabel.do {
//            $0.text = "19:54"
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailGrayscale(.gray600)
        }
        
        btnImageView.do {
            $0.image = .btnTicketShare.resized(CGSize(width: 44, height: 44))
        }
        
        firstInfoView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 80, height: 94)
            $0.addStroke(color: .korailGrayscale(.gray100))
        }
        secondInfoView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 80, height: 94)
            $0.addStroke(color: .korailGrayscale(.gray100))
        }
        thirdInfoView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 80, height: 94)
            $0.addStroke(color: .korailGrayscale(.gray100))
        }
        
        let labels = [
            firstInfoLabel,
            secondInfoLabel,
            thirdInfoLabel,
            fourthInfoLabel
        ]
        labels.enumerated().forEach { index, label in
            let titles = ["승차권", "호차번호", "좌석번호", "운임영수증"]
            
            label.font = .korailCaption(.caption1sb12)
            label.text = titles[index]
        }
        
        reloadImageView.do {
            $0.image = .icnMyticketRefreshL.resized(CGSize(width: 30, height: 30))
        }
        timeDescriptionLabel.do {
            $0.text = "15분전에\n표시됩니다"
            $0.numberOfLines = 2
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailBlue(.blue02)
            $0.textAlignment = .center
        }
        
        trainNumberLabel.do {
            $0.text = "4"
            $0.font = .korailHead(.head2m28)
            $0.textColor = .korailBlue(.blue02)
        }
        trainDescriptionLabel.do {
            $0.text = "호차"
            $0.font = .korailBody(.body1sb14)
            $0.textColor = .korailBlue(.blue02)
        }
        
        seatLabel.do {
//            $0.text = "16A"
            $0.font = .korailHead(.head2m28)
            $0.textColor = .korailBlue(.blue02)
        }
        windowLabel.do {
            $0.text = "창측"
            $0.font = .korailBody(.body1sb14)
            $0.textColor = .korailBlue(.blue02)
        }
        qrImageView.do {
            $0.image = .imgMyticketQr.resized(CGSize(width: 48, height: 48.65))
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
        }
        
        serviceView.do {
            $0.backgroundColor = .korailGrayscale(.gray50)
            $0.makeCornerRadius(cornerRadius: 12)
        }
        serviceDescriptionLabel.do {
            $0.text = "이런 서비스는 어떠세요?"
            $0.font = .korailBody(.body1sb14)
            $0.textColor = .korailGrayscale(.gray700)
        }
        serviceStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        [reportStackView, helperStackView, smsStackView].forEach {
            $0.do {
                $0.axis = .vertical
                $0.spacing = 8
                $0.alignment = .center
                $0.isLayoutMarginsRelativeArrangement = true
                $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                    top: 4,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                )
            }
        }
        reportImageView.do {
            $0.image = .icnMyticketReport.resized(CGSize(width: 38, height: 38))
        }
        reportLabel.do {
            $0.text = "철도범죄신고"
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailGrayscale(.gray500)
        }
        helperImageView.do {
            $0.image = .icnMyticketHelp.resized(CGSize(width: 38, height: 38))
        }
        helperLabel.do {
            $0.text = "승하차 도우미 신청"
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailGrayscale(.gray300)
        }
        smsImageView.do {
            $0.image = .icnMyticketSms.resized(CGSize(width: 38, height: 38))
        }
        smslLabel.do {
            $0.text = "보호자 안심 SMS"
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailGrayscale(.gray300)
        }
        
        //TODO: 쪼끔 흐르다가 멈춤;;; ㅠㅠ 어케 하지
        animationView.do {
            // 루프모드가 작동을 아예 안함
            $0.loopMode = .autoReverse
            $0.play()
        }
        navbarImageView.do {
            $0.image = .cmpMyTicketBtmNavbar
        }
        
        toastView.do {
            $0.isHidden = true
            $0.makeCornerRadius(cornerRadius: 8)
            $0.backgroundColor = .korailBlue(.blue01)
        }
        toastLabel.do {
            $0.text = "승차권 상세정보를 로딩중입니다"
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailBasic(.white)
        }
        
    }
    
    private func setHierarchy() {
        
        addSubviews(
            headerImageView,
            scrollView,
            toastView,
            animationView,
            navbarImageView
        )
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            ticketTitleView,
            ticketImageView,
            serviceView
        )
        ticketTitleView.addSubviews(dateLabel, trainNameView)
        trainNameView.addSubview(trainNameLabel)
        ticketImageView.addSubviews(
            trainTimeLocationStackView,
            infoButton,
            btnImageView,
            firstInfoView,
            secondInfoView,
            thirdInfoView,
            fourthInfoView,
            buttonStackView
        )
        trainTimeLocationStackView.addArrangedSubviews(
            departureStackview,
            arrowImageView,
            arrivalStackView
        )
        departureStackview.addArrangedSubviews(
            departureLocationLabel,
            departureTimeLabel
        )
        arrivalStackView.addArrangedSubviews(
            arrivalLocationLabel,
            arrivalTimeLabel
        )
        firstInfoView.addSubviews(
            firstInfoLabel,
            reloadImageView,
            timeDescriptionLabel
        )
        secondInfoView.addSubviews(
            secondInfoLabel,
            trainNumberLabel,
            trainDescriptionLabel
        )
        thirdInfoView.addSubviews(
            thirdInfoLabel,
            seatLabel,
            windowLabel
        )
        fourthInfoView.addSubviews(
            fourthInfoLabel,
            qrImageView
        )
        buttonStackView.addArrangedSubviews(
            passButton,
            cancleButton,
            changeButton
        )
        serviceView.addSubviews(
            serviceDescriptionLabel,
            serviceStackView,
            serviceButton
        )
        serviceStackView.addArrangedSubviews(
            reportStackView,
            helperStackView,
            smsStackView
        )
        reportStackView.addArrangedSubviews(reportImageView, reportLabel)
        helperStackView.addArrangedSubviews(helperImageView, helperLabel)
        smsStackView.addArrangedSubviews(smsImageView, smslLabel)
        toastView.addSubview(toastLabel)
        
    }
    
    private func setLayout() {
        
        scrollView.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(headerImageView.snp.bottom)
            $0.bottom.equalTo(animationView.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(720)
        }
        
        headerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        ticketTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(60) // 원래 44
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        trainNameView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(12)
            $0.width.equalTo(106)
            $0.height.equalTo(20)
        }
        trainNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(ticketTitleView.snp.bottom).offset(-16)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(398)
            $0.width.equalTo(355)
        }
        trainTimeLocationStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview().inset(26)
            $0.width.equalTo(295)
            $0.height.equalTo(58)
        }
        departureStackview.snp.makeConstraints {
            $0.width.equalTo(109)
        }
        
        arrivalStackView.snp.makeConstraints {
            $0.width.equalTo(109)
        }
        
        infoButton.snp.makeConstraints {
            $0.top.equalTo(trainTimeLocationStackView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(271)
            $0.height.equalTo(44)
        }
        btnImageView.snp.makeConstraints {
            $0.top.equalTo(trainTimeLocationStackView.snp.bottom).offset(40)
            $0.leading.equalTo(infoButton.snp.trailing).offset(8)
        }
        
        firstInfoView.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom).offset(52)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(94)
        }
        reloadImageView.snp.makeConstraints {
            $0.top.equalTo(firstInfoLabel.snp.bottom).offset(9.5)
            $0.centerX.equalToSuperview()
        }
        timeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(reloadImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        secondInfoView.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom).offset(52)
            $0.leading.equalTo(firstInfoView.snp.trailing)
            $0.width.equalTo(80)
        }
        trainNumberLabel.snp.makeConstraints {
            $0.top.equalTo(secondInfoLabel.snp.bottom).offset(23.5)
            $0.leading.equalToSuperview().inset(17.5)
        }
        trainDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(secondInfoLabel.snp.bottom).offset(23.5 + 9)
            $0.leading.equalTo(trainNumberLabel.snp.trailing)
        }
        
        thirdInfoView.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom).offset(52)
            $0.leading.equalTo(secondInfoView.snp.trailing)
            $0.width.equalTo(80)
        }
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(thirdInfoLabel.snp.bottom).offset(14.5)
            $0.centerX.equalToSuperview()
        }
        windowLabel.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        fourthInfoView.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom).offset(52)
            $0.leading.equalTo(thirdInfoView.snp.trailing)
            $0.width.equalTo(80)
        }
        qrImageView.snp.makeConstraints {
            $0.top.equalTo(fourthInfoLabel.snp.bottom).offset(15.68)
            $0.centerX.equalToSuperview()
        }
        
        [firstInfoLabel, secondInfoLabel, thirdInfoLabel, fourthInfoLabel].forEach {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(firstInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        [passButton, cancleButton, changeButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(105)
                $0.height.equalTo(50)
            }
        }
        
        serviceView.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.width.equalTo(355)
            $0.height.equalTo(180)
        }
        serviceDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        serviceStackView.snp.makeConstraints {
            $0.top.equalTo(serviceDescriptionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(72)
            $0.width.equalTo(323)
        }
        serviceButton.snp.makeConstraints {
            $0.top.equalTo(serviceStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(323)
            $0.height.equalTo(44)
        }
        toastView.snp.makeConstraints {
            $0.bottom.equalTo(animationView.snp.top).offset(-13)
            $0.horizontalEdges.equalToSuperview().inset(72)
            $0.height.equalTo(34)
            $0.width.equalTo(230)
        }
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        animationView.snp.makeConstraints {
            $0.bottom.equalTo(navbarImageView.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(25)
        }
        navbarImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(26)
        }
    }
    
}

extension MyTicketView {
    
    func toast() {
        
        UIView.animate(withDuration: 0.3) {
            self.toastView.isHidden = false
            self.toastView.alpha = 0.9
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 3) {
                self.toastView.alpha = 0
            } completion: { _ in
                self.toastView.isHidden = true
            }
        }
    }
    
    func bindData(ticket: Ticket?) {
        guard let ticket else { return }
        
        dateLabel.text = getToday(date: ticket.date)
        departureTimeLabel.text = ticket.departureTime
        arrivalTimeLabel.text = ticket.arrivalTime
        trainNameLabel.text = ticket.trainName
        seatLabel.text = ticket.seatName
    }
    
    func getToday(date: String) -> String{

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy.MM.dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = inputFormatter.date(from: date) else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        
        return outputFormatter.string(from: date)
    }
}

