//
//  SeatRowView.swift
//  KORAILTALK-iOS
//
//  Created by 조호근 on 11/21/24.
//

import UIKit

import SnapKit
import Then

protocol SeatRowViewDelegate: AnyObject {
    func seatRowView(_ seatRowView: SeatRowView, didSelectSeat seatId: Int)
}

class SeatRowView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SeatRowViewDelegate?
    private var selectedSeatId: Int?
    private var seats: [Seat] = []
    
    // MARK: - Lazy Image Properties
    
    private lazy var forwardImage: UIImage = .icnSeatmapForwardActivate.withRenderingMode(.alwaysOriginal)
    private lazy var backwardImage: UIImage = .icnSeatmapBackwardActivate.withRenderingMode(.alwaysOriginal)
    private lazy var soldForwardImage: UIImage = .icnSeatmapForwardInactive.withRenderingMode(.alwaysOriginal)
    private lazy var soldBackwardImage: UIImage = .icnSeatmapBackwardInactive.withRenderingMode(.alwaysOriginal)
    private lazy var selectedForwardImage: UIImage = .icnSeatmapForwardSelected.withRenderingMode(.alwaysOriginal)
    private lazy var selectedBackwardImage: UIImage = .icnSeatmapBackwardSelected.withRenderingMode(.alwaysOriginal)
    
    // MARK: - UI Properties
    
    private var seatButtons: [UIButton] = []
    private let arrowImageView = UIImageView()
    
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

extension SeatRowView {
    
    // MARK: - Layout
    
    private func setStyle() {
        arrowImageView.do {
            $0.image = .polygon5.withRenderingMode(.alwaysOriginal)
        }
    }
    
    private func setHierarchy() {
        self.addSubview(arrowImageView)
    }
    
    private func setLayout() {
        arrowImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(19)
            $0.height.equalTo(18)
        }
    }
    
    // MARK: - func
    
    func configure(with seats: [Seat]) {
        self.seats = seats
        
        seatButtons.forEach { $0.removeFromSuperview() }
        seatButtons = []
        
        for seat in seats {
            let button = makeSeatButton(for: seat)
            seatButtons.append(button)
            addSubview(button)
        }
        
        layoutSeats()
    }
    
}

extension SeatRowView {
    
    // MARK: - Private Func Button
    
    private func makeSeatButton(for seat: Seat) -> UIButton {
        let button = UIButton()
        
        let background = seat.isSold ? (
            seat.direction ? soldForwardImage : soldBackwardImage
        ) : (
            seat.direction ? forwardImage : backwardImage
        )
        button.setBackgroundImage(background, for: .normal)
        
        button.setTitle(seat.seatName, for: .normal)
        button.titleLabel?.font = .korailCaption(.caption2m12)
        
        if seat.isSold {
            button.setTitleColor(.korailGrayscale(.gray400), for: .normal)
        } else {
            button.setTitleColor(.korailGrayscale(.gray900), for: .normal)
        }
        
        button.isEnabled = !seat.isSold
        button.tag = seat.seatId
        
        let seatButtonTapped = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.handleSeatSelection(seatId: seat.seatId)
        }
        button.addAction(seatButtonTapped, for: .touchUpInside)
        
        return button
    }
    
    private func handleSeatSelection(seatId: Int) {
        // 선택된 좌석이 있고 현재 선택한 좌석이 아닌 경우 아무 동작도 하지 않음
        if let selectedSeatId = selectedSeatId, selectedSeatId != seatId {
            return
        }
        
        if selectedSeatId == seatId {
            selectedSeatId = nil
        } else {
            selectedSeatId = seatId
        }
        
        updateButtonStyles()
        
        if let selectedSeatId = selectedSeatId {
            delegate?.seatRowView(self, didSelectSeat: selectedSeatId)
        }
    }
    
    private func updateButtonStyles() {
        for button in seatButtons {
            guard let seat = seats.first(where: { $0.seatId == button.tag }) else { continue }
            
            let imageName: UIImage = {
                if seat.isSold {
                    return seat.direction ? soldForwardImage : soldBackwardImage
                } else if button.tag == selectedSeatId {
                    return seat.direction ? selectedForwardImage : selectedBackwardImage
                } else {
                    return seat.direction ? forwardImage : backwardImage
                }
            }()
            
            button.setBackgroundImage(imageName, for: .normal)
            
            if button.tag == selectedSeatId {
                button.setTitleColor(.korailBasic(.white), for: .normal)
            } else if seat.isSold {
                button.setTitleColor(.korailGrayscale(.gray400), for: .normal)
            } else {
                button.setTitleColor(.korailGrayscale(.gray900), for: .normal)
            }
        }
    }
    
    private func layoutSeats() {
        guard !seatButtons.isEmpty else { return }
        
        let totalSeats = seatButtons.count
        
        switch totalSeats {
        case 1:
            seatButtons[0].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-91)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
        case 2:
            seatButtons[0].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-91)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[1].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-35)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
        case 3:
            seatButtons[0].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-91)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[1].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-35)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[2].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.leading.equalTo(arrowImageView.snp.trailing).offset(34)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
        case 4:
            seatButtons[0].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-91)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[1].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.trailing.equalTo(arrowImageView.snp.leading).offset(-35)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[2].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.leading.equalTo(arrowImageView.snp.trailing).offset(34)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
            seatButtons[3].snp.makeConstraints {
                $0.centerY.equalTo(arrowImageView)
                $0.leading.equalTo(arrowImageView.snp.trailing).offset(90.5)
                $0.width.equalTo(50)
                $0.height.equalTo(48)
            }
            
        default:
            print("Unexpected number of seats")
        }
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    let fourSeatsArray = Array(Coach.mock.seats.prefix(4))
    
    let rowView = SeatRowView()
    rowView.configure(with: fourSeatsArray)
    
    return rowView.toPreview()
}

#endif
