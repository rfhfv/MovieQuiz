//
//  RegistrationPresenter.swift
//  MovieQuiz
//
//  Created by admin on 22.08.2025.
//

import Foundation

final class RegistrationPresenter {
    private weak var viewController: RegistrationViewController?
    
    init(viewController: RegistrationViewController? = nil) {
        self.viewController = viewController
    }
    
    enum ValidationError: LocalizedError {
        case invalidName
        case invalidPassword
        
        var errorDescription: String? {
            switch self {
            case .invalidName:
                return "Имя должно быть больше 2х симлволов"
            case .invalidPassword:
                return "Пароль должен содержать минимум 4 символа: вклячая одну цифру и заглавную букву"
            }
        }
    }
    
    func validate(data: UserRegistrationData) -> Result<Void, ValidationError> {
        guard data.name.count >= 2 else {
            return.failure(.invalidName)
        }
        guard isValidPassword(data.password) else {
            return.failure(.invalidPassword)
        }
        return .success(())
    }
    
    func savenameToStorage(_ name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let uppercase = CharacterSet.uppercaseLetters
        let digits = CharacterSet.decimalDigits
        return password.rangeOfCharacter(from: uppercase) != nil &&
        password.rangeOfCharacter(from: digits) != nil &&
        password.count >= 4
    }
}
