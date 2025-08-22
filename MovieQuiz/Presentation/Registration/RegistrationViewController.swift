//
//  RegistrationViewController.swift
//  MovieQuiz
//
//  Created by admin on 21.08.2025.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private lazy var registrationView = RegistrationView()
    private var presenter = RegistrationPresenter()
    
    override func loadView() {
        super.loadView()
        view  = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        presenter = RegistrationPresenter(viewController: self)
    }
}

private extension RegistrationViewController {
    func navigateToMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let mainVC = FactoryController.makeMovieQuizViewController()
            self?.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    func setupBindings() {
        registrationView.setRegistrationTarget(self, action: #selector(handleRegistration))
        registrationView.observeTextFields(target: self, action: #selector(inputsDidChange))
        registrationView.setRegistrationEnable(false)
        addKeyboardDismissGesture()
    }
    
    func addKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleRegistration() {
        let data = UserRegistrationData(
            name: registrationView.name ?? "",
            password: registrationView.password ?? ""
        )
        registrationView.hideValidationError()
        
        switch presenter.validate(data: data) {
        case .success(()):
            presenter.savenameToStorage(data.name)
            navigateToMainScreen()
        case .failure(let error):
            registrationView.showValidationError(message: error.localizedDescription)
        }
    }
    
    @objc func inputsDidChange() {
        let name = registrationView.name ?? ""
        let password = registrationView.password ?? ""
        
        let fieldsFilled = !name.isEmpty && !password.isEmpty && password.count >= 4
        registrationView.setRegistrationEnable(fieldsFilled)
    }
}
