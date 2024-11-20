//
//  TrainSearchFilterView.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

// 임시
var dayList: [String] = []

final class TrainSearchFilterView: UIView {

    // MARK: - UI Properties
    
    private let containerStackView = UIStackView()
    
    private let dateButton = UIButton()
    
    private let selectStackView = UIStackView()
    private let trainSelectButton = UIButton()
    private let seatSelectButton = UIButton()
    private let transferSelectButton = UIButton()
    
    //MARK: - Properties
    
    private var dateButtonConfiguration = UIButton.Configuration.plain()
    private var selectButtonConfiguration = UIButton.Configuration.plain()
    
    weak var delegate: FilterDelegate?

    //MARK: - Life Cycle
    
    init() {
        
        super.init(frame: .zero)
        
        setStyle()
        setHierachy()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TrainSearchFilterView {
    
    private func setStyle() {
        
        // date button style
        var dateContainer = AttributeContainer()
        dateContainer.font = UIFont.korailTitle(.title3m16)
        dateContainer.foregroundColor = UIColor.korailBasic(.black)
        
        if let resizedImage = UIImage(resource: .icnSearchArrowDown)
            .resized(CGSize(width: 24, height: 24)) {
            dateButtonConfiguration.image = resizedImage
        } else { return }
        
        dateButtonConfiguration.imagePlacement = .trailing
        dateButtonConfiguration.contentInsets = .zero
        dateButtonConfiguration.imagePadding = 0
        //TODO: 피그마.... 날짜가 뚱뚱해지면 줄바뀜되어요.... 너비조정필요할듯?
        dateButtonConfiguration.attributedTitle = AttributedString("\(getToday())", attributes: dateContainer)
        
        // select buttons style
        var selectContainer = AttributeContainer()
        selectContainer.font = UIFont.korailBody(.body2m14)
        selectContainer.foregroundColor = UIColor.korailGrayscale(.gray500)
        
        if let resizedImage = UIImage(resource: .icnTrainSearchArrowDown)
            .resized(CGSize(width: 18, height: 18)) {
            selectButtonConfiguration.image = resizedImage
        } else { return }
        
        selectButtonConfiguration.imagePlacement = .trailing
        selectButtonConfiguration.contentInsets = .zero
        selectButtonConfiguration.imagePadding = 4

        let selectButtons = [
            trainSelectButton,
            seatSelectButton,
            transferSelectButton
        ]
        
        selectButtons.enumerated().forEach { index, button in
            
            button.configuration = selectButtonConfiguration
            
            let titles = ["모든열차", "일반석", "직통"]
            
            var attributedTitle = AttributedString(titles[index])
            attributedTitle.font = UIFont.korailBody(.body2m14)
            attributedTitle.foregroundColor = UIColor.korailGrayscale(.gray500)
            button.configuration?.attributedTitle = attributedTitle
        }
        
        containerStackView.do {
            $0.axis = .horizontal
            $0.backgroundColor = UIColor.korailBlue(.blue07)
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 27
            
            // stackview에 padding 주기
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 12,
                leading: 16,
                bottom: 12,
                trailing: 10
            )
        }
        dateButton.do {
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.configuration = dateButtonConfiguration
            $0.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        }
        selectStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
        trainSelectButton.do {
            $0.addTarget(self, action: #selector(trainSelectButtonTapped), for: .touchUpInside)
        }
        seatSelectButton.do {
            $0.addTarget(self, action: #selector(seatSelectButtonTapped), for: .touchUpInside)
        }
        transferSelectButton.do {
            $0.addTarget(self, action: #selector(transferSelectButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setHierachy() {
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubviews(dateButton, selectStackView)
        selectStackView.addArrangedSubviews(
            trainSelectButton,
            seatSelectButton,
            transferSelectButton
        )
        
    }
    
    private func setLayout() {
        
        containerStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        dateButton.snp.makeConstraints {
            //TODO: 여기서!!!! 너비조정
            $0.width.equalTo(129)
        }
        selectStackView.snp.makeConstraints {
            $0.width.equalTo(193)
        }
        trainSelectButton.snp.makeConstraints {
            $0.width.equalTo(71)
        }
        seatSelectButton.snp.makeConstraints {
            $0.width.equalTo(59)
        }
        transferSelectButton.snp.makeConstraints {
            $0.width.equalTo(47)
        }
    
    }
    
    //MARK: - @objc
    
    @objc
    func trainSelectButtonTapped() {
        delegate?.showBottomSheet(title: "모든열차", bottomType: .blue, listType: trainList)
    }
    
    @objc
    func seatSelectButtonTapped() {
        delegate?.showBottomSheet(title: "일반석", bottomType: .blue, listType: seatList)
    }
    
    @objc
    func transferSelectButtonTapped() {
        delegate?.showBottomSheet(title: "직통", bottomType: .blue, listType: transferList)
    }
    
    @objc
    func dateButtonTapped() {
        delegate?.showDateCollectionView()
    }

}

extension TrainSearchFilterView {
    
    private func getToday() -> String {

        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let today = Date()
        for i in 0..<14 {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: today) else { return "" }
            
            let modifiedMonth = Calendar.current.component(.month, from: modifiedDate)
            let modifiedDay = Calendar.current.component(.day, from: modifiedDate)
            let modifiedWeekday = Calendar.current.component(.weekday, from: modifiedDate)
            
            dayList.append("\(modifiedMonth).\(modifiedDay) (\(changeWeekday(modifiedWeekday)))")
        }
        
        return "\(year).\(month).\(day) (\(changeWeekday(weekday)))"
    }
    
    private func changeWeekday(_ weekday: Int) -> String {
        
        switch weekday {
        case 1: return "일"
        case 2: return "월"
        case 3: return "화"
        case 4: return "수"
        case 5: return "목"
        case 6: return "금"
        case 7: return "토"
        default:
            return ""
        }
        
    }
    
}
