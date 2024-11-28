//
//  LPointModalViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/26/24.
//

import UIKit

protocol PointDelegate: AnyObject {
    func applyPoint(pointAmount: Int)
}

final class LPointModalViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = LPointModalView()
    
    weak var delegate: PointDelegate?
    
    var userLPointValue = 1000
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
        
//        NetworkService.shared.userService.getUserLPoint(parameter: 123456) { [weak self] response in
//            guard let self else { return }
//            switch response {
//            case .success(let data):
//                userLPointValue = data?.data.point
//            default:
//                break
//            }
//        }
    }
}

extension LPointModalViewController {
    
    // MARK: - Private Func
    
    private func setAddTarget() {
        rootView.pointPasswordTextField.delegate = self
        rootView.pointTextField.delegate = self
        rootView.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        rootView.checkPasswordButton.addTarget(self, action: #selector(checkPasswordButtonTapped), for: .touchUpInside)
        rootView.applyAllAmountButton.addTarget(self, action: #selector(applyAllAmountButtonTapped), for: .touchUpInside)
        rootView.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
        rootView.toolBarButton.addTarget(self, action: #selector(toolbarButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc

    @objc private func xButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func checkPasswordButtonTapped() {
        rootView.pointTextField.isEnabled = true
        rootView.pointTextField.becomeFirstResponder()
        rootView.applyAllAmountButton.isEnabled = true
        rootView.pointPasswordTextField.isEnabled = false
    }
    
    @objc private func applyAllAmountButtonTapped() {
        rootView.applyAllAmount()
    }
    
    @objc private func checkBoxButtonTapped() {
        rootView.checkBoxButton.isSelected.toggle()
        
        if rootView.checkBoxButton.isSelected && rootView.pointTextField.text != "" {
            rootView.toolBarButton.changeButtonState(isEnabled: true)
        } else {
            rootView.toolBarButton.changeButtonState(isEnabled: false)
        }
    }

    @objc private func toolbarButtonTapped() {
        let pointAmount = Int(rootView.pointTextField.text ?? "") ?? 0
        delegate?.applyPoint(pointAmount: pointAmount)
        self.dismiss(animated: true)
    }
}

extension LPointModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        guard let maxLength = LPointTextFieldType(rawValue: textField.tag)?.maxLength else { return true }
        return newText.count <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case rootView.pointPasswordTextField:
            if textField.text?.count == LPointTextFieldType(rawValue: textField.tag)?.maxLength {
                rootView.checkPasswordButton.isEnabled = true
            } else {
                rootView.checkPasswordButton.isEnabled = false
            }
        case rootView.pointTextField:
            if let inputNum = textField.text {
                if Int(inputNum) ?? 0 >= userLPointValue {
                    textField.text = String(userLPointValue)
                } else if Int(inputNum) == 0 {
                    textField.text = "0"
                } else if inputNum.first == "0" && inputNum.count > 1 {
                    textField.text?.removeFirst()
                }
            }
            
            if rootView.checkBoxButton.isSelected && rootView.pointTextField.text != "" && rootView.pointTextField.text != "0" {
                rootView.toolBarButton.changeButtonState(isEnabled: true)
            } else {
                rootView.toolBarButton.changeButtonState(isEnabled: false)
            }
        default:
            return
        }
    }
}
