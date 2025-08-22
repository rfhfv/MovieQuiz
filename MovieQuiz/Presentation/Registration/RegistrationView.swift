//
//  RegistrationView.swift
//  MovieQuiz
//
//  Created by admin on 21.08.2025.
//

import UIKit

final class RegistrationView: UIView {
    private lazy var nameTextField = makeTextField()
    private lazy var passwordTextField = makeTextField()
    
    private let imageView = UIImageView(image: UIImage(named: "Logo"))
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 18)
        button.layer.cornerRadius = 14
        button.tintColor = .ypDarkGray
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YSDisplay-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = .ypWhite
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YSDisplay-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = .ypWhite
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YSDisplay-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = .ypRed
        label.textAlignment = .center
        return label
    }()
    
    private let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypBackground
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {
    var name: String? { nameTextField.text}
    var password: String? { passwordTextField.text }
    
    func setRegistrationTarget(_ target: Any?, action: Selector) {
        registrationButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func showValidationError(message: String) {
        errorLabel.text = message
        registrationButton.shake()
    }
    
    func hideValidationError() {
        errorLabel.text = ""
    }
    
    func setRegistrationEnable(_ isEnabled: Bool) {
        registrationButton.isEnabled = isEnabled
        registrationButton.backgroundColor = isEnabled ? .ypBlue : .ypWhite
        registrationButton.tintColor = isEnabled ? .ypWhite : .ypDarkGray
    }
    
    func observeTextFields(target: Any?, action: Selector) {
        [nameTextField, passwordTextField].forEach {
            $0.addTarget(target, action: action, for: .editingChanged)
        }
    }
}

private extension RegistrationView {
    func setupViews() {
        setupFieldStack()
        setupTextField()
        configureLayout()
    }
    
    func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.layer.backgroundColor = UIColor.ypWhite.cgColor
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }
    
    func setupTextField() {
        nameLabel.text = "Имя"
        nameLabel.font = UIFont(name: "YSDisplay-Medium", size: 16)
        
        passwordLabel.text = "Пароль"
        passwordLabel.font = UIFont(name: "YSDisplay-Medium", size: 16)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupFieldStack() {
        fieldStack.addArrangedSubview(nameLabel)
        fieldStack.addArrangedSubview(nameTextField)
        fieldStack.addArrangedSubview(passwordLabel)
        fieldStack.addArrangedSubview(passwordTextField)
    }
    
    func configureLayout() {
        addSubview(fieldStack)
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fieldStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fieldStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            fieldStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 270),
            
            imageView.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -70),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            registrationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            registrationButton.heightAnchor.constraint(equalToConstant: 60),
            registrationButton.widthAnchor.constraint(equalToConstant: 250),
            
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            errorLabel.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -25)
        ])
    }
}
