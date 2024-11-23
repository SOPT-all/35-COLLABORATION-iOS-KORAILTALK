//
//  TrainSearchFilterView.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

final class TrainSearchFilterView: UIView {

    // MARK: - UI Properties
    
    let dateButton = UIButton()
    
    private let selectStackView = UIStackView()
    let trainSelectButton = UIButton()
    let seatSelectButton = UIButton()
    let transferSelectButton = UIButton()
    
    //MARK: - Properties
    
    var dateButtonConfiguration = UIButton.Configuration.plain()
    private var selectButtonConfiguration = UIButton.Configuration.plain()
    
    private let trainList: [String] = ["모든열차", "KTX", "ITX", "무궁화"]
    private let seatList: [String] = ["일반석", "유아동반", "휠체어", "전동휠체어", "2층석", "자전거", "대피도우미"]
    private let transferList: [String] = ["직통", "환승"]
    private var todayText = "" {
        didSet {
            redrawDate()
        }
    }
    var dateIndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            getToday(index: dateIndexPath)
        }
    }

    //MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        
        getToday(index: IndexPath(row: 0, section: 0))
        setStyle()
        setHierachy()
        setLayout()
    
        backgroundColor = .korailBlue(.blue07)
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
        
        dateButtonConfiguration.image = .icnSearchArrowDown.resized(CGSize(width: 24, height: 24))
        dateButtonConfiguration.imagePlacement = .trailing
        dateButtonConfiguration.contentInsets = .zero
        
        dateButtonConfiguration.imagePadding = 0
        //TODO: 채우기
        dateButtonConfiguration.attributedTitle = AttributedString("\(todayText)", attributes: dateContainer)
        
        
        // select buttons style
        var selectContainer = AttributeContainer()
        selectContainer.font = UIFont.korailBody(.body2m14)
        selectContainer.foregroundColor = UIColor.korailGrayscale(.gray500)
        
        selectButtonConfiguration.image = .icnTrainSearchArrowDown.resized(CGSize(width: 18, height: 18))
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
            button.tag = index
            
            let titles = ["모든열차", "일반석", "직통"]
            
            var attributedTitle = AttributedString(titles[index])
            attributedTitle.font = UIFont.korailBody(.body2m14)
            attributedTitle.foregroundColor = UIColor.korailGrayscale(.gray500)
            button.configuration?.attributedTitle = attributedTitle
        }

        dateButton.do {
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.configuration = dateButtonConfiguration
        }
        selectStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 8
        }
    }
    
    private func setHierachy() {
        
        addSubviews(dateButton, selectStackView)
        selectStackView.addArrangedSubviews(
            trainSelectButton,
            seatSelectButton,
            transferSelectButton
        )
        
    }
    
    private func setLayout() {
    
        dateButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(129)
            $0.leading.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        selectStackView.snp.makeConstraints {
            $0.width.equalTo(193)
            $0.trailing.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(12)
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

}

extension TrainSearchFilterView {
    
    func getToday(index: IndexPath){

        guard let modifiedDate = Calendar.current.date(byAdding: .day, value: index.row, to: Date()) else { return }
        
        let modifedYear = Calendar.current.component(.year, from: modifiedDate)
        let modifiedMonth = Calendar.current.component(.month, from: modifiedDate)
        let modifiedDay = Calendar.current.component(.day, from: modifiedDate)
        let modifiedWeekday = Calendar.current.component(.weekday, from: modifiedDate)
        
        todayText = "\(modifedYear).\(modifiedMonth).\(modifiedDay) (\(changeWeekday(modifiedWeekday)))"
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

extension TrainSearchFilterView {
    
    private func redrawDate() {
        
        // date button style
        var dateContainer = AttributeContainer()
        dateContainer.font = UIFont.korailTitle(.title3m16)
        dateContainer.foregroundColor = UIColor.korailBasic(.black)
        
        dateButtonConfiguration.image = .icnSearchArrowUp.resized(CGSize(width: 24, height: 24))
        dateButtonConfiguration.imagePlacement = .trailing
        dateButtonConfiguration.contentInsets = .zero
        
        dateButtonConfiguration.imagePadding = 0
        //TODO: 채우기
        dateButtonConfiguration.attributedTitle = AttributedString("\(todayText)", attributes: dateContainer)
        
        dateButton.configuration = dateButtonConfiguration
        
    }

}

