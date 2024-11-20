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
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setStyle()
        setHierachy()
        setLayout()
        
        setNavigationBar()
        setCollectionView()
        
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
    
    private func setStyle() {
        
        trainSearchFilterView.do {
            $0.delegate = self
        }
        
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
