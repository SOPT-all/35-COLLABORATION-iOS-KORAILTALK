//
//  SelectBottomSheetViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

enum BottomType {
    case blue, purple
}

// 열차조회임시
public let trainList: [String] = ["모든열차", "KTX", "ITX", "무궁화"]
public let seatList: [String] = ["일반석", "유아동반", "휠체어", "전동휠체어", "2층석", "자전거", "대피도우미"]
public let transferList: [String] = ["직통", "환승"]

// 결제임시
public let myCardList: [String] = ["직접입력", "내 현대카드"]
public let cardType: [String] = ["개인", "법인"]
public let installmentsList: [String] = ["일시불", "3개월", "6개월"]

/// 사용법 예시
/// SelectBottomSheetViewController(
/// title: "열차선택",
/// bottomType: .blue,
/// listType: trainList
/// )

final class SelectBottomSheetViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private let bottomSheetView = UIView()
    private let dimmedBackView = UIView()
    
    private let headerStackView = UIStackView()
    private var titleLabel = UILabel()
    private let closeButton = UIButton()

    private var contentTableView = UITableView()
    
    //MARK: - Properties
    
    private var type: BottomType = .blue
    private var pointTextColor = UIColor()
    private var pointBackgroundColor = UIColor()
    private var selectList: [String] = []
    
    //MARK: - Life Cycle
    
    init(
        title: String,
        bottomType: BottomType,
        listType: [String]
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.titleLabel.text = title
        self.type = bottomType
        self.selectList = listType
        
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setStyle()
        setHierachy()
        setLayout()
        
        setBottomColor()
        dimmedBackViewTapped()
        
        let indexPath = IndexPath(row: 0, section: 0)
        contentTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        showBottomSheet()
    }

}

extension SelectBottomSheetViewController {
    
    private func setStyle() {
        
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
            $0.font = .korailTitle(.title1sb18)
        }
        
        closeButton.do {
            if let resizedImage = UIImage(resource: .icnX38)
                .resized(CGSize(width: 38, height: 38)) {
                $0.setImage(resizedImage, for: .normal)
            }
            $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        }
        
        contentTableView.do {
            $0.register(SelectBottomSheetTableViewCell.self,
                        forCellReuseIdentifier: SelectBottomSheetTableViewCell.className)
            $0.rowHeight = 50
            $0.dataSource = self
            $0.separatorStyle = .none
            
        }
        
    }
    
    private func setHierachy() {
        
        view.addSubviews(dimmedBackView, bottomSheetView)
        bottomSheetView.addSubviews(headerStackView, contentTableView)
        headerStackView.addArrangedSubviews(titleLabel, closeButton)
        
    }
    
    private func setLayout() {
        
        dimmedBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(100)
        }
        headerStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        contentTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(headerStackView.snp.bottom)
        }
        
    }
    
    private func setBottomColor() {
        switch type {
        case .blue:
            pointTextColor = .korailBlue(.blue02)
            pointBackgroundColor = .korailBlue(.blue07)
        case .purple:
            pointTextColor = .korailPurple(.purple02)
            pointBackgroundColor = .korailPurple(.purple05)
        }
    }
    
    @objc
    private func closeButtonTapped() {
        hideBottomSheet()
    }
    //TODO: contentTableView랑 headerStackView의 애니메이션이 다름... 왤까
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.1) {
            self.dimmedBackView.backgroundColor = .korailBasic(.black).withAlphaComponent(0.5)
            
            self.bottomSheetView.snp.remakeConstraints {
                $0.bottom.leading.trailing.equalToSuperview()
                $0.height.equalTo(50 * self.selectList.count + 32 + 62)
            }
            // 곧바로 UI를 업데이트
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func hideBottomSheet() {
        UIView.animate(withDuration: 0.1, animations: {
            self.dimmedBackView.backgroundColor = .clear
            self.bottomSheetView.snp.remakeConstraints {
                $0.bottom.leading.trailing.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
    
    private func dimmedBackViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheet))
        dimmedBackView.addGestureRecognizer(tap)
        dimmedBackView.isUserInteractionEnabled = true
    }
    
}

extension SelectBottomSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectBottomSheetTableViewCell.className, for: indexPath) as? SelectBottomSheetTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bindData(string: selectList[indexPath.row])
        cell.selectionStyle = .none
        
        cell.selectedBackgroundColor = pointBackgroundColor
        cell.selectedTextColor = pointTextColor
        
        return cell
    }

}