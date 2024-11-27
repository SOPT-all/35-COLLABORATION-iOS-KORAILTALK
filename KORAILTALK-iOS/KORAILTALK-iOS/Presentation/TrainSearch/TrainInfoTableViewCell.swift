//
//  TrainListTableViewCell.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/21/24.
//

import UIKit

class TrainInfoTableViewCell: UITableViewCell {
    
    //MARK: - UI Properties
    
    private let trainNameView = UIView()
    private let trainNameLabel = UILabel()
    
    private let timeStackView = UIStackView()
    private let departureLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let arrivalLabel = UILabel()
    
    let standardButton = TrainPriceButton()
    private let premiumButton = TrainPriceButton()
    
    private let stroke = UIView()
    
    private let lastView = UIView()
    let nextDayButton = UIButton()
    
    //MARK: - Properties
    
    private var buttonConfiguration = UIButton.Configuration.plain()
    var tomorrow: String = ""
    var isLastCell: Bool = false {
        didSet {
            subviews.forEach {
                $0.removeFromSuperview()
            }
            if isLastCell {
                drawLastCell(tomorrow: tomorrow)
            } else {
                drawCell()
            }
        }
    }
    
    var tapAction: (() -> Void)?
    
    //MARK: - Life Cycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            if isLastCell {
                drawLastCell(tomorrow: tomorrow)
            } else {
                drawCell()
            }

        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawCell() {
        
        setStyle()
        setHierachy()
        setLayout()
        
        func setStyle() {
            
            trainNameView.do {
                $0.backgroundColor = .korailBlue(.blue02)
                $0.makeCornerRadius(cornerRadius: 10)
            }
            trainNameLabel.do {
                $0.font = .korailCaption(.caption2m12)
                $0.textColor = .korailBasic(.white)
            }
            
            timeStackView.do {
                $0.axis = .horizontal
                $0.spacing = 5
            }
            departureLabel.do {
                $0.text = "05:13"
                $0.font = .korailTitle(.title2m18)
            }
            arrowImageView.do {
                $0.image = .icnTrainSearchArrowRight.resized(CGSize(width: 24, height: 24))
            }
            arrivalLabel.do {
                $0.text = "07:49"
                $0.font = .korailTitle(.title2m18)
            }
            
            standardButton.do {
                $0.type = .standardSell
                $0.price = 32000
                $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
            premiumButton.do {
                $0.type = .premiumSell
                $0.price = 83700
            }
            
            stroke.do {
                $0.backgroundColor = .korailGrayscale(.gray200)
            }
        }
        
        func setHierachy() {
            
            addSubviews(trainNameView, timeStackView, stroke, standardButton, premiumButton)
            
            trainNameView.addSubview(trainNameLabel)
            timeStackView.addArrangedSubviews(
                departureLabel,
                arrowImageView,
                arrivalLabel
            )
            sendSubviewToBack(contentView)
        }
        
        
        func setLayout() {
            trainNameView.snp.makeConstraints {
                $0.width.equalTo(106)
                $0.height.equalTo(20)
                $0.leading.equalToSuperview().inset(16)
                $0.top.equalToSuperview().inset(19)
            }
            trainNameLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            timeStackView.snp.makeConstraints {
                $0.width.equalTo(134)
                $0.height.equalTo(24)
                $0.leading.equalToSuperview().inset(22)
                $0.top.equalToSuperview().inset(50)
            }
            
            standardButton.snp.makeConstraints {
                $0.width.equalTo(77)
                $0.height.equalTo(58)
                $0.leading.equalToSuperview().inset(193)
                $0.top.equalToSuperview().inset(18)
            }
            premiumButton.snp.makeConstraints {
                $0.width.equalTo(77)
                $0.height.equalTo(58)
                $0.leading.equalToSuperview().inset(282)
                $0.top.equalToSuperview().inset(18)
            }
            
            stroke.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
    }
    
    
    // 마지막 cell일 경우 다음날로 넘어가는 버튼
    
    private func drawLastCell(tomorrow: String) {
        
        var container = AttributeContainer()
        container.font = .korailTitle(.title3m16)
        container.foregroundColor = .korailBlue(.blue01)
        
        buttonConfiguration.attributedTitle = AttributedString("다음날 (\(tomorrow)) 조회하기", attributes: container)
        buttonConfiguration.background.strokeColor = .korailGrayscale(.gray200)
        buttonConfiguration.background.cornerRadius = 25
        
        lastView.do {
            $0.backgroundColor = .white
        }
        nextDayButton.do {
            $0.configuration = buttonConfiguration
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        addSubview(lastView)
        lastView.addSubview(nextDayButton)
        
        lastView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        nextDayButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(355)
            $0.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        subviews.forEach {
            $0.removeFromSuperview()
        }
        
        tapAction = nil
        
        if isLastCell {
            drawLastCell(tomorrow: tomorrow)
        } else {
            drawCell()
        }
    }
    
    func bindData(train: TrainInfo) {
        trainNameLabel.text = train.name
    }
}

extension TrainInfoTableViewCell {
    @objc
    func buttonTapped() {
        tapAction?()
    }
}
