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
    
    private let standardButton = TrainPriceButton()
    private let premiumButton = TrainPriceButton()
    
    private let stroke = UIView()
    
    //MARK: - Properties
    
    private var soldButtonConfiguration = UIButton.Configuration.plain()
    private var sellButtonConfiguration = UIButton.Configuration.plain()
    
    //MARK: - Life Cycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setStyle()
            setHierachy()
            setLayout()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    //
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    private func setStyle() {
        
        trainNameView.do {
            $0.backgroundColor = .korailBlue(.blue02)
            $0.makeCornerRadius(cornerRadius: 10)
        }
        trainNameLabel.do {
            $0.text = "KTX 001"
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
            $0.type = .standardSoldOut
        }
        premiumButton.do {
            $0.type = .premiumSell
            $0.price = 83700
        }
        
        stroke.do {
            $0.backgroundColor = .korailGrayscale(.gray200)
        }
    }
    
    private func setHierachy() {
        addSubviews(trainNameView, timeStackView, stroke, standardButton, premiumButton)
        trainNameView.addSubview(trainNameLabel)
        timeStackView.addArrangedSubviews(
            departureLabel,
            arrowImageView,
            arrivalLabel
        )
    }
    
    
    private func setLayout() {
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

