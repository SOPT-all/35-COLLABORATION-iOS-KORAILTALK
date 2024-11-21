//
//  TrainSearchViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

final class TrainSearchViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private let trainSearchFilterView = TrainSearchFilterView()
    private let dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: - Properties
    
    private var dayList: [String] = []
    private let trainList: [String] = ["모든열차", "KTX", "ITX", "무궁화"]
    private let seatList: [String] = ["일반석", "유아동반", "휠체어", "전동휠체어", "2층석", "자전거", "대피도우미"]
    private let transferList: [String] = ["직통", "환승"]
    private var isDateShow: Bool = false
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setHierachy()
        setLayout()
        
        setNavigationBar()
        setCollectionView()
        setAddTarget()
        
        getDayList()
        
        let indexPath = IndexPath(row: 0, section: 0)
        dateCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
    }
    
    private func setNavigationBar() {
        self.title = "열차 조회"
        
        self.setCustomBackButton()
        
        let reloadButtonTapped = UIAction { _ in
            // TODO: 새로고침
            print("reloadButtonTapped")
        }
        let reloadButton = UIButton(type: .system).then {
            $0.setImage(.icnReload.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(reloadButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let menuButtonTapped = UIAction { _ in
            // TODO: 메뉴버튼
            print("menuButtonTapped")
        }
        let menuButton = UIButton(type: .system).then {
            $0.setImage(.icnMenu.withRenderingMode(.alwaysOriginal), for: .normal)
            $0.addAction(menuButtonTapped, for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 44, height: 44))
            }
        }
        
        let rightStackView = UIStackView(arrangedSubviews: [reloadButton, menuButton]).then {
            $0.axis = .horizontal
            $0.spacing = 0
        }
        
        let customBarView = UIBarButtonItem(customView: rightStackView)
        navigationItem.rightBarButtonItem = customBarView
        
    }
    
    private func setHierachy() {
        view.addSubviews(trainSearchFilterView, dateCollectionView)
    }
    
    private func setLayout() {
        
        trainSearchFilterView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        dateCollectionView.snp.makeConstraints {
            $0.top.equalTo(trainSearchFilterView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
    }
    
    private func setCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 86, height: 34)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        dateCollectionView.do {
            $0.backgroundColor = .korailGrayscale(.gray100)
            $0.isHidden = true
            $0.setCollectionViewLayout(layout, animated: true)
            $0.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.className)
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
        }
        
    }
}

extension TrainSearchViewController {
    
    private func setAddTarget() {
        trainSearchFilterView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        trainSearchFilterView.trainSelectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        trainSearchFilterView.seatSelectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        trainSearchFilterView.transferSelectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func selectButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            showBottomSheet(title: "모든열차", bottomType: .blue, listType: trainList)
        case 1:
            showBottomSheet(title: "일반석", bottomType: .blue, listType: seatList)
        case 2:
            showBottomSheet(title: "직통", bottomType: .blue, listType: transferList)
        default:
            return
        }
    }
    
    @objc
    func dateButtonTapped() {
        showDateCollectionView()
        if !isDateShow {
            if let resizedImage = UIImage(resource: .icnSearchArrowUp)
                .resized(CGSize(width: 24, height: 24)) {
                trainSearchFilterView.dateButtonConfiguration.image = resizedImage
            } else { return }
            trainSearchFilterView.dateButton.configuration = trainSearchFilterView.dateButtonConfiguration
            isDateShow.toggle()
        } else {
            if let resizedImage = UIImage(resource: .icnSearchArrowDown)
                .resized(CGSize(width: 24, height: 24)) {
                trainSearchFilterView.dateButtonConfiguration.image = resizedImage
            } else { return }
            trainSearchFilterView.dateButton.configuration = trainSearchFilterView.dateButtonConfiguration
            isDateShow.toggle()
        }
        
    }
    
}

extension TrainSearchViewController {
    private func getDayList() {
 
        let today = Date()
        for i in 0..<14 {
            guard let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: today) else { return }
            
            let modifiedMonth = Calendar.current.component(.month, from: modifiedDate)
            let modifiedDay = Calendar.current.component(.day, from: modifiedDate)
            let modifiedWeekday = Calendar.current.component(.weekday, from: modifiedDate)
            
            dayList.append("\(modifiedMonth).\(modifiedDay) (\(changeWeekday(modifiedWeekday)))")
        }

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

extension TrainSearchViewController: FilterDelegate {
    
    func showBottomSheet(title: String, bottomType: BottomType, listType: [String]) {
        
        let viewController = SelectBottomSheetViewController(
            title: title,
            bottomType: bottomType,
            listType: listType
        )
        self.present(viewController, animated: false)
        
    }
    
    func showDateCollectionView() {
        dateCollectionView.isHidden.toggle()
    }
    
}

extension TrainSearchViewController: UICollectionViewDelegate {
    
}

extension TrainSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.className, for: indexPath) as? DateCollectionViewCell else {
            return UICollectionViewCell()
        }
        item.bindData(dayList[indexPath.row])
        
        return item
    }
    
}
