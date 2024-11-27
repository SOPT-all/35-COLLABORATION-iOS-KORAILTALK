//
//  TrainCheckPopupViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/27/24.
//

import UIKit

import SnapKit
import Then

class TrainCheckPopupViewController: BasePopupViewController {
    
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let listLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
}

extension TrainCheckPopupViewController {
    
    private func setStyle() {
        setTitle("꼭 알아두세요!")
        
        firstLabel.do {
            $0.text = "승차권 환불(반환) 위약금을 반드시 확인하시기 바랍니다."
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailBasic(.red)
        }
        
        secondLabel.do {
            $0.text = "휴대폰 세부 승차기준"
            $0.font = .korailCaption(.caption1sb12)
            $0.textColor = .korailBasic(.black)
        }
        
        listLabel.do {
            $0.numberOfLines = 0
            
            $0.attributedText = NSAttributedString(NSAttributedString.makeAttributedString(
                text: """
                1. 코레일톡에서 구매한 승차권은 역창구에서 변경 시 할인이\n취소 될 수 있습니다.
                2. 할인 승차권의 할인율은 별도 공지없이 변경될 수 있습니다.
                3. 할인은 운임에만 적용하고 요금은 미적용(특실/우등실은 운임
                과 요금으로 구분)되며, 최저운임 이하로 할인하지 않습니다.
                4. 승차 시 해당열차 승차권을 소지해야 하며, 사진이나 캡쳐한
                화면은 유효한 승차권이 아닙니다.
                5. 반려동물은 다른 고객에게 불편을 주지 않도록 케이스 (이동
                장)에 반드시 넣어주시기 바라며, 신체 일부가 밖으로 나오지
                않도록 해야 합니다.
                6. 반려동물의 동반좌석이 필요한 경우에는 정상운임을 내고 좌
                석을 지정받아 이용할 수 있습니다.
                7. 승차권을 2매 이상 구매할 시, 홈페이지•코레일톡•역 창구를
                통해 동행자 마일리지 적립을 신청할 수 있습니다.
                8. 전달하기 제외승차권
                  • 회원 본인만 사용 가능한 할인 상품(힘내라청춘, 청소년
                    드림, 정기승차권 등)
                  • 좌석을 지정하지 않는 입석, 자유석 승차권
                """,
                color: .korailGrayscale(.gray500),
                font: .korailCaption(.caption2m12),
                lineSpacing: 4
            ))
            $0.highlightText(targetText: "특실/우등실은 운임\n과 요금으로 구분", color: .korailBasic(.red))
            $0.highlightText(targetText: "사진이나 캡쳐한\n화면은 유효한 승차권이 아닙니다.", color: .korailBasic(.red))
        }
    }
    
    private func setHierarchy() {
        contentView.addSubviews(
            firstLabel,
            secondLabel,
            listLabel
        )
    }
    
    private func setLayout() {
        firstLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        listLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            
        }
    }
}


