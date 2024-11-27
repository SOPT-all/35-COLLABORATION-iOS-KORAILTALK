//
//  TrainSearchViewController.swift
//  KORAILTALK-iOS
//
//  Created by 최주리 on 11/19/24.
//

import UIKit

import SnapKit
import Then

// 임시
public struct TrainInfo {
    let name: String
}

final class TrainSearchViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private let trainSearchFilterView = TrainSearchFilterView()
    private let dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let trainInfoTableView = UITableView()
    
    //임시
    private let trainInfoList: [TrainInfo] = [
        TrainInfo(name: "KTX1"),
        TrainInfo(name: "KTX2"),
        TrainInfo(name: "KTX3"),
        TrainInfo(name: "KTX4"),
        TrainInfo(name: "KTX5"),
        TrainInfo(name: "KTX6"),
        TrainInfo(name: "KTX7"),
        TrainInfo(name: "KTX8"),
        TrainInfo(name: "KTX9"),
    ]
    
    private var dayList: [String] = []
    private let trainList: [String] = ["모든열차", "KTX", "ITX", "무궁화"]
    private let seatList: [String] = ["일반석", "유아동반", "휠체어", "전동휠체어", "2층석", "자전거", "대피도우미"]
    private let transferList: [String] = ["직통", "환승"]
    
    private var isDateShow: Bool = false
    private var tomorrow: String = ""
    private var selectedDateIndexPath = IndexPath(row: 0, section: 0)
    private var selectedTrainInfoIndexPath: IndexPath?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        getTomorrow(1)
        getDayList()
        
        setStyle()
        setHierachy()
        setLayout()
        
        setNavigationBar()
        setCollectionView()
        setAddTarget()
        
        dateCollectionView.selectItem(at: selectedDateIndexPath, animated: true, scrollPosition: .left)
        
    }

}

extension TrainSearchViewController {
    
    private func setNavigationBar() {
        title = "열차 조회"
        
        setCustomBackButton()
        
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
    
    private func setStyle() {
        
        trainInfoTableView.do {
            $0.register(TrainInfoTableViewCell.self, forCellReuseIdentifier: TrainInfoTableViewCell.className)
            $0.rowHeight = 94
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        }
    }
    
    private func setHierachy() {
        view.addSubviews(
            trainSearchFilterView,
            dateCollectionView,
            trainInfoTableView
        )
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
        trainInfoTableView.snp.makeConstraints {
            $0.top.equalTo(trainSearchFilterView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
            trainSearchFilterView.dateButtonConfiguration.image = .icnSearchArrowUp.resized(CGSize(width: 24, height: 24))
            trainSearchFilterView.dateButton.configuration = trainSearchFilterView.dateButtonConfiguration
            
            trainInfoTableView.snp.remakeConstraints {
                $0.top.equalTo(dateCollectionView.snp.bottom)
                $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            isDateShow.toggle()
        } else {
            trainSearchFilterView.dateButtonConfiguration.image = .icnSearchArrowDown.resized(CGSize(width: 24, height: 24))
            trainSearchFilterView.dateButton.configuration = trainSearchFilterView.dateButtonConfiguration
            trainInfoTableView.snp.remakeConstraints {
                $0.top.equalTo(trainSearchFilterView.snp.bottom)
                $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            isDateShow.toggle()
        }
        
    }
    
    @objc
    private func nextDayButtonTapped() {
        
        //TODO: 왜 첫번째 버튼은 동작을 하지 않는 걸까...
        let nextItem = selectedDateIndexPath.item + 1
        if nextItem < dateCollectionView.numberOfItems(inSection: 0) {
            let nextIndexPath = IndexPath(row: nextItem, section: 0)
            dateCollectionView.selectItem(at: nextIndexPath, animated: true, scrollPosition: .left)
            
            getTomorrow(nextIndexPath.row + 1)
            selectedDateIndexPath = nextIndexPath
            trainSearchFilterView.getToday(index: selectedDateIndexPath)
            
            // 테이블뷰 스크롤 위로 올리기
            trainInfoTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
    }
    
    @objc
    private func standardButtonTapped() {
        let viewController = TrainDetailBottomSheetViewController(
            dateText: "2024.11.16 (토)",
            trainName: "KTX 001",
            departureTime: "05:27",
            arrivalTime: "08:15",
            time: "2시간 48분"
        )
        viewController.delegate = self
        present(viewController, animated: false)
    }
    
}

extension TrainSearchViewController {
    
    private func getTomorrow(_ value: Int) {
        guard let modifiedDate = Calendar.current.date(byAdding: .day, value: value, to: Date()) else { return }
        let modifiedMonth = Calendar.current.component(.month, from: modifiedDate)
        let modifiedDay = Calendar.current.component(.day, from: modifiedDate)
        
        tomorrow = "\(modifiedMonth)월 \(modifiedDay)일"
    }
    
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

extension TrainSearchViewController {
    
    func showBottomSheet(title: String, bottomType: BottomType, listType: [String]) {
        
        let viewController = SelectBottomSheetViewController(
            title: title,
            bottomType: bottomType,
            listType: listType
        )
        present(viewController, animated: false)
        
    }
    
    func showDateCollectionView() {
        dateCollectionView.isHidden.toggle()
    }
    
}

extension TrainSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        trainSearchFilterView.dateIndexPath = indexPath
        getTomorrow(indexPath.row + 1)
        selectedDateIndexPath = indexPath
        trainInfoTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        trainSearchFilterView.getToday(index: selectedDateIndexPath)
        
        //TODO: 날짜에 따른 기차시간표 API 호출
        
    }
    
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

extension TrainSearchViewController: UITableViewDelegate {

}

extension TrainSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainInfoList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainInfoTableViewCell.className) as? TrainInfoTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        if indexPath.row == trainInfoList.count {
            cell.tomorrow = tomorrow
            cell.isLastCell = true
            cell.tapAction = { [weak self] in
                self?.nextDayButtonTapped()
            }
        } else {
            cell.isLastCell = false
            cell.bindData(train: trainInfoList[indexPath.row])
            cell.tapAction = { [weak self] in
                self?.selectedTrainInfoIndexPath = indexPath
                self?.standardButtonTapped()
                cell.standardButton.isSelected = true
            }
        }
        return cell
    }
}

extension TrainSearchViewController: BottomSheetDelegate {
    
    func bottomSheetDidDismiss() {
        if let indexPath = selectedTrainInfoIndexPath {
            let cell = trainInfoTableView.cellForRow(at: indexPath) as? TrainInfoTableViewCell
            cell?.standardButton.isSelected = false
            cell?.standardButton.setStyle()
        }
    }
    
    func didDismissAndNavigateToSeat() {
        let viewController = SeatSelectionViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}