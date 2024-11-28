//
//  TrainDetailBottomSheetViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/24/24.
//

import UIKit

final class TrainDetailBottomSheetViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private let bottomSheetView = UIView()
    private let dimmedBackView = UIView()
    
    private let headerStackView = UIStackView()
    private var titleLabel = UILabel()
    private let closeButton = UIButton()
    
    private let dateNameView = UIView()
    private let dateLabel = UILabel()
    private let trainNameView = UIView()
    private let trainNameLabel = UILabel()
    
    private let trainTimeLocationStackView = UIStackView()
    private let departureStackview = UIStackView()
    private let departureLocationLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let timeStackView = UIStackView()
    private let arrowImageView = UIImageView()
    private let timeLabel = UILabel()
    private let arrivalStackView = UIStackView()
    private let arrivalLocationLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    
    private let timetableButton = UIButton()
    private let priceButton = UIButton()
    
    private let timetableImageView = UIImageView()
    private let priceImageView = UIImageView()
    
    private let selectSeatButton = UIButton()
    private let autoButton = UIButton()
    
    //MARK: - Properties
    
    private var timetableButtonConfiguration = UIButton.Configuration.plain()
    private var priceButtonConfiguration = UIButton.Configuration.plain()
    private var selectButtonConfiguration = UIButton.Configuration.plain()
    private var autoButtonConfiguration = UIButton.Configuration.plain()
    
    private var isTimetableImageHidden = true
    private var isPriceImageHidden = true
    
    weak var delegate: BottomSheetDelegate?
    
    //MARK: - Life Cycle
    
    //날짜, 기차이름, 출발시간, 도착시간, 소요시간
    init(
        dateText: String,
        trainName: String,
        departureTime: String,
        arrivalTime: String,
        time: String
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.dateLabel.text = dateText
        self.trainNameLabel.text = trainName
        self.departureTimeLabel.text = departureTime
        self.arrivalTimeLabel.text = arrivalTime
        self.timeLabel.text = time
        
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setStyle()
        setHierarchy()
        setLayout()
        
        dimmedBackViewTapped()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        showBottomSheet()
    }
    
}

extension TrainDetailBottomSheetViewController {
    
    private func setStyle() {
        
        var timetableContainer = AttributeContainer()
        timetableContainer.font = .korailBody(.body2m14)
        timetableContainer.foregroundColor = .korailBasic(.black)
        
        timetableButtonConfiguration.background.cornerRadius = 8
        timetableButtonConfiguration.background.strokeColor = .korailGrayscale(.gray200)
        timetableButtonConfiguration.image = .icnTrainSearchArrowDown.resized(CGSize(width: 24, height: 24))
        timetableButtonConfiguration.imagePadding = 238
        timetableButtonConfiguration.imagePlacement = .trailing
        timetableButtonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        timetableButtonConfiguration.attributedTitle = setButtonLabel(title: "시간표", image: .icnTrainSearchTimetable)
        
        var priceContainer = AttributeContainer()
        priceContainer.font = .korailBody(.body2m14)
        priceContainer.foregroundColor = .korailBasic(.black)
        
        priceButtonConfiguration.background.cornerRadius = 8
        priceButtonConfiguration.background.strokeColor = .korailGrayscale(.gray200)
        priceButtonConfiguration.image = .icnTrainSearchArrowDown.resized(CGSize(width: 24, height: 24))
        priceButtonConfiguration.imagePadding = 226
        priceButtonConfiguration.imagePlacement = .trailing
        priceButtonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        priceButtonConfiguration.attributedTitle = setButtonLabel(title: "운임요금", image: .icnTrainSearchMoney)
        
        var selectContainer = AttributeContainer()
        selectContainer.font = .korailTitle(.title3m16)
        selectContainer.foregroundColor = .korailBlue(.blue01)
        
        selectButtonConfiguration.background.cornerRadius = 26
        selectButtonConfiguration.background.strokeColor = .korailGrayscale(.gray200)
        selectButtonConfiguration.attributedTitle = AttributedString("좌석 선택", attributes: selectContainer)
        
        var autoContainer = AttributeContainer()
        autoContainer.font = .korailTitle(.title3m16)
        autoContainer.foregroundColor = .korailBasic(.white)
        
        autoButtonConfiguration.background.cornerRadius = 26
        autoButtonConfiguration.background.backgroundColor = .korailBlue(.blue03)
        autoButtonConfiguration.attributedTitle = AttributedString("자동 배정", attributes: autoContainer)
        
        bottomSheetView.do {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .systemBackground
        }
        headerStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 12,
                leading: 22,
                bottom: 12,
                trailing: 10
            )
        }
        titleLabel.do {
            $0.text = "기차 상세"
            $0.font = .korailTitle(.title1sb18)
        }
        closeButton.do {
            $0.setImage(.icnX38.resized(CGSize(width: 38, height: 38)), for: .normal)
            $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        }
        
        dateNameView.do {
            $0.backgroundColor = .korailBlue(.blue07)
        }
        dateLabel.do {
            $0.font = .korailTitle(.title3m16)
        }
        trainNameView.do {
            $0.backgroundColor = .korailBlue(.blue02)
            $0.makeCornerRadius(cornerRadius: 10)
        }
        trainNameLabel.do {
            $0.font = .korailCaption(.caption2m12)
            $0.textColor = .korailBasic(.white)
        }
        
        trainTimeLocationStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 16
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 20,
                leading: 39,
                bottom: 20,
                trailing: 39
            )
        }
        departureStackview.do {
            $0.axis = .vertical
            $0.alignment = .center
        }
        departureLocationLabel.do {
            $0.text = "서울"
            $0.font = .korailHead(.head5m20)
        }
        departureTimeLabel.do {
            $0.font = .korailBody(.body3r14)
        }
        timeStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
        }
        arrowImageView.do {
            $0.image = .icnTrainSearchArrowRightBlue.resized(CGSize(width: 24, height: 24))
        }
        timeLabel.do {
            $0.font = .korailCaption(.caption4m10)
            $0.textColor = .korailGrayscale(.gray500)
        }
        arrivalStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
        }
        arrivalLocationLabel.do {
            $0.text = "부산"
            $0.font = .korailHead(.head5m20)
        }
        arrivalTimeLabel.do {
            $0.font = .korailBody(.body3r14)
        }
        timetableButton.do {
            $0.configuration = timetableButtonConfiguration
            $0.addTarget(self, action: #selector(timetableButtonTapped), for: .touchUpInside)
        }
        priceButton.do {
            $0.configuration = priceButtonConfiguration
            $0.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        }
        //height: 208
        timetableImageView.do {
            $0.image = .imgTraininfoTimetable
        }
        //height: 308
        priceImageView.do {
            $0.image = .imgTraininfoFee
        }
        selectSeatButton.do {
            $0.configuration = selectButtonConfiguration
            $0.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        }
        //TODO: 승차권 정보 확인 view로 넘어가게 하기
        autoButton.do {
            $0.configuration = autoButtonConfiguration
            $0.addTarget(self, action: #selector(autoButtonTapped), for: .touchUpInside)
        }

    }
    
    private func setHierarchy() {
        view.addSubviews(dimmedBackView, bottomSheetView)
        bottomSheetView.addSubviews(
            headerStackView,
            dateNameView,
            trainTimeLocationStackView,
            timetableButton,
            timetableImageView,
            priceButton,
            priceImageView,
            selectSeatButton,
            autoButton
        )
        headerStackView.addArrangedSubviews(titleLabel, closeButton)
        dateNameView.addSubviews(dateLabel, trainNameView)
        trainNameView.addSubview(trainNameLabel)
        trainTimeLocationStackView.addArrangedSubviews(
            departureStackview,
            timeStackView,
            arrivalStackView
        )
        departureStackview.addArrangedSubviews(
            departureLocationLabel,
            departureTimeLabel
        )
        timeStackView.addArrangedSubviews(arrowImageView, timeLabel)
        arrivalStackView.addArrangedSubviews(
            arrivalLocationLabel,
            arrivalTimeLabel
        )
    }
    
    private func setLayout() {
        
        dimmedBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(442)
            $0.height.equalTo(442)
        }
        headerStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        dateNameView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        trainNameView.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(106)
            $0.height.equalTo(20)
        }
        trainNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        trainTimeLocationStackView.snp.makeConstraints {
            $0.top.equalTo(dateNameView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(78)
        }
        departureStackview.snp.makeConstraints {
            $0.width.equalTo(109)
        }
        timeStackView.snp.makeConstraints {
            $0.width.equalTo(47)
        }
        arrivalStackView.snp.makeConstraints {
            $0.width.equalTo(109)
        }
        
        timetableButton.snp.makeConstraints {
            $0.top.equalTo(trainTimeLocationStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(48)
            $0.width.equalTo(355)
        }
        priceButton.snp.makeConstraints {
            $0.top.equalTo(timetableButton.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(48)
            $0.width.equalTo(355)
        }
        selectSeatButton.snp.makeConstraints {
            $0.top.equalTo(priceButton.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalTo(174)
        }
        autoButton.snp.makeConstraints {
            $0.top.equalTo(priceButton.snp.bottom).offset(18)
            $0.leading.equalTo(selectSeatButton.snp.trailing).offset(7)
            $0.height.equalTo(50)
            $0.width.equalTo(174)
        }
    }
    
    private func setButtonLabel(title: String, image: UIImage) -> AttributedString {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 18, height: 18)
        
        let attributedString = NSMutableAttributedString()
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.korailBody(.body2m14),
            .foregroundColor: UIColor.korailBasic(.black)
        ]
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        let spacingString = NSAttributedString(
            string: " ",
            attributes: [.kern: 1]
        )

        let textString = NSAttributedString(string: title, attributes: textAttributes)
        
        attributedString.append(imageString)
        attributedString.append(spacingString)
        attributedString.append(textString)
        
        return AttributedString(attributedString)
    }
    
}

extension TrainDetailBottomSheetViewController {
    
    @objc
    private func closeButtonTapped() {
        hideBottomSheet()
    }
    
    @objc
    private func hideBottomSheet() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.dimmedBackView.backgroundColor = .clear
            self?.bottomSheetView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(702)
            }
            self?.view.layoutIfNeeded()
            
            self?.delegate?.bottomSheetDidDismiss()
            
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
    
    private func dimmedBackViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheet))
        dimmedBackView.addGestureRecognizer(tap)
        dimmedBackView.isUserInteractionEnabled = true
    }
    
    private func showBottomSheet() {
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            
            self?.dimmedBackView.backgroundColor = .korailBasic(.black).withAlphaComponent(0.5)
            
            self?.bottomSheetView.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func timetableButtonTapped() {
        
        if isTimetableImageHidden {
            
            if !isPriceImageHidden {
                priceButtonTapped()
            }
            
            timetableImageView.isHidden = false
            bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(442 + 208)
            }
            timetableButton.snp.remakeConstraints {
                $0.top.equalTo(trainTimeLocationStackView.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(55)
                $0.width.equalTo(355)
            }
            timetableImageView.snp.makeConstraints {
                $0.top.equalTo(timetableButton.snp.bottom).offset(-7)
                $0.leading.equalToSuperview().inset(10)
            }
            priceButton.snp.remakeConstraints {
                $0.top.equalTo(timetableImageView.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(48)
                $0.width.equalTo(355)
            }
            
            view.layoutIfNeeded()
        } else {
            
            timetableImageView.isHidden = true
            
            bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(442)
            }
            timetableImageView.snp.removeConstraints()
            timetableButton.snp.makeConstraints {
                $0.top.equalTo(trainTimeLocationStackView.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(48)
                $0.width.equalTo(355)
            }
            priceButton.snp.remakeConstraints {
                $0.top.equalTo(self.timetableButton.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(48)
                $0.width.equalTo(355)
            }
            
            view.layoutIfNeeded()
        }
        
        isTimetableImageHidden.toggle()
    }
    
    @objc
    private func priceButtonTapped() {
        
        if isPriceImageHidden {
            
            if !isTimetableImageHidden {
                timetableButtonTapped()
            }
            priceImageView.isHidden = false
            bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(702)
            }
            priceButton.snp.remakeConstraints {
                $0.top.equalTo(timetableButton.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(55)
                $0.width.equalTo(355)
            }
            priceImageView.snp.makeConstraints {
                $0.top.equalTo(priceButton.snp.bottom).offset(-7)
                $0.leading.equalToSuperview().inset(10)
            }
            
            selectSeatButton.snp.remakeConstraints {
                $0.top.equalTo(priceImageView.snp.bottom).offset(18)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(50)
                $0.width.equalTo(174)
            }
            autoButton.snp.remakeConstraints {
                $0.top.equalTo(priceImageView.snp.bottom).offset(18)
                $0.leading.equalTo(selectSeatButton.snp.trailing).offset(7)
                $0.height.equalTo(50)
                $0.width.equalTo(174)
            }
            
            view.layoutIfNeeded()
        } else {
            priceImageView.isHidden = true
            bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(442)
            }
            priceImageView.snp.removeConstraints()
            priceButton.snp.remakeConstraints {
                $0.top.equalTo(timetableButton.snp.bottom).offset(8)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(48)
                $0.width.equalTo(355)
            }
            selectSeatButton.snp.remakeConstraints {
                $0.top.equalTo(priceButton.snp.bottom).offset(18)
                $0.leading.equalToSuperview().inset(10)
                $0.height.equalTo(50)
                $0.width.equalTo(174)
            }
            autoButton.snp.remakeConstraints {
                $0.top.equalTo(priceButton.snp.bottom).offset(18)
                $0.leading.equalTo(selectSeatButton.snp.trailing).offset(7)
                $0.height.equalTo(50)
                $0.width.equalTo(174)
            }
            view.layoutIfNeeded()
        }
        
        isPriceImageHidden.toggle()
    }
    
    @objc
    private func selectButtonTapped() {
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.dimmedBackView.backgroundColor = .clear
            self?.bottomSheetView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(702)
            }
            self?.view.layoutIfNeeded()
            
            self?.delegate?.bottomSheetDidDismiss()
            
        }, completion: { _ in
            self.dismiss(animated: false) { [weak self] in
                self?.delegate?.didDismissAndNavigateToSeat()
            }
        })
        
    }
    
    @objc
    private func autoButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.dimmedBackView.backgroundColor = .clear
            self?.bottomSheetView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(702)
            }
            self?.view.layoutIfNeeded()
            
            self?.delegate?.bottomSheetDidDismiss()
            
        }, completion: { _ in
            self.dismiss(animated: false) { [weak self] in
                self?.delegate?.didDismissAndnavigateToCheck()
            }
        })
    }
    
}

protocol BottomSheetDelegate: AnyObject {
    func bottomSheetDidDismiss()
    func didDismissAndNavigateToSeat()
    func didDismissAndnavigateToCheck()
}
