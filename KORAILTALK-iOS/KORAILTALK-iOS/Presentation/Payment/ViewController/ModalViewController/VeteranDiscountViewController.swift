//
//  VeteranDiscountViewController.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/25/24.
//

import UIKit

protocol DiscountDelegate: AnyObject {
    func applyDiscount()
}

final class VeteranDiscountViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = VeteranDiscountView()
    
    weak var delegate: DiscountDelegate?
    
    private var veteranIDValue = false
    private var passwordValue = false
    private var verificationCodeValue = false
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
}

extension VeteranDiscountViewController {
    
    // MARK: - Private Func
    
    private func setAddTarget() {
        rootView.veteranIDTextField.delegate = self
        rootView.passwordTextField.delegate = self
        rootView.verificationCodeField.delegate = self
        rootView.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        rootView.checkVeteranIDButton.addTarget(self, action: #selector(checkVeteranIDButtonTapped), for: .touchUpInside)
        rootView.toolBarButton.addTarget(self, action: #selector(toolbarButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc

    @objc private func xButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func checkVeteranIDButtonTapped() {
        rootView.toolBarButton.changeButtonState(isEnabled: true)
    }
    
    @objc private func toolbarButtonTapped() {
        delegate?.applyDiscount()
        self.dismiss(animated: true)
    }
}

extension VeteranDiscountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        guard let maxLength = VeteranDiscountTextFieldType(rawValue: textField.tag)?.maxLength else { return false }
        return newText.count <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let value = textField.text?.count == VeteranDiscountTextFieldType(rawValue: textField.tag)?.maxLength
        
        switch textField {
        case rootView.veteranIDTextField:
            veteranIDValue = value
        case rootView.passwordTextField:
            passwordValue = value
        case rootView.verificationCodeField:
            verificationCodeValue = value
        default:
            return
        }

        if veteranIDValue && passwordValue && verificationCodeValue {
            rootView.checkVeteranIDButton.isEnabled = true
        } else {
            rootView.checkVeteranIDButton.isEnabled = false
            rootView.toolBarButton.changeButtonState(isEnabled: false)
        }
    }
}
