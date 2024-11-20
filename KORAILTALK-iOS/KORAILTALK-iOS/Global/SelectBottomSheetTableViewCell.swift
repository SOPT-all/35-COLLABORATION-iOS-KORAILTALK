//
//  SelectBottomSheetTableViewCell.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

final class SelectBottomSheetTableViewCell: UITableViewCell {
    
    //MARK: - UI Properties
    
    private let stackView = UIStackView()
    private let label = UILabel()
    private let checkImage = UIImageView()
    private var resizedImage = UIImage()
    
    // 주입 받을 부분
    var selectedBackgroundColor: UIColor = .systemBackground {
        didSet {
            
            if selectedBackgroundColor == UIColor.korailPurple(.purple05) {
                resizedImage = UIImage(resource: .icnCheckPurple)
                    .resized(CGSize(width: 38, height: 38)) ?? UIImage()
            } else {
                resizedImage = UIImage(resource: .icnCheckBlue)
                    .resized(CGSize(width: 38, height: 38)) ?? UIImage()
            }
            
            checkImage.image = resizedImage
        }
    }
    var selectedTextColor: UIColor = .korailBasic(.black)
    
    //MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseidentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseidentifier)
        
        setStyle()
        setHierachy()
        setLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        
        stackView.do {
            $0.axis = .horizontal
            $0.isLayoutMarginsRelativeArrangement = true
            $0.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: 0,
                leading: 22,
                bottom: 0,
                trailing: 10
            )
        }
        label.do {
            $0.font = UIFont.korailTitle(.title3m16)
        }
        
    }
    
    private func setHierachy() {
        
        addSubview(stackView)
        stackView.addArrangedSubviews(label, checkImage)
        
    }
    
    private func setLayout() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        if selected {
            checkImage.isHidden = false
            backgroundColor = selectedBackgroundColor
            label.textColor = selectedTextColor
        } else {
            checkImage.isHidden = true
            backgroundColor = .systemBackground
            label.textColor = .korailBasic(.black)
        }
        
    }
    
    func bindData(string: String) {
        label.text = string
    }

}

