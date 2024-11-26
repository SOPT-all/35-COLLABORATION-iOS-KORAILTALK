import UIKit
import SnapKit
import Then

class BasePopupView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    let contentView = UIView()
    private let confirmButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        backgroundColor = .black.withAlphaComponent(0.5)
        
        containerView.do {
            $0.backgroundColor = .korailBasic(.white)
            $0.makeCornerRadius(cornerRadius: 16)
        }
        
        titleLabel.do {
            $0.font = .korailTitle(.title3m16)
            $0.textColor = .korailGrayscale(.gray900)
            $0.textAlignment = .center
        }
        
        confirmButton.do {
            $0.backgroundColor = .korailBlue(.blue01)
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.korailBasic(.white), for: .normal)
            $0.titleLabel?.font = .korailBody(.body1m16)
            $0.makeCornerRadius(cornerRadius: 8)
        }
    }
    
    private func setHierarchy() {
        addSubview(containerView)
        containerView.addSubviews(
            titleLabel,
            contentView,
            confirmButton
        )
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setConfirmAction(_ action: UIAction) {
        confirmButton.addAction(action, for: .touchUpInside)
    }
} 