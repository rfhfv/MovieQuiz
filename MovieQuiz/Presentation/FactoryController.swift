//
//  FactoryController.swift
//  MovieQuiz
//
//  Created by admin on 21.08.2025.
//

import Foundation

final class FactoryController {
    static func makeRegistrationController() ->  RegistrationViewController {
        let controller = RegistrationViewController()
        return controller
    }
    
    static func makeMovieQuizViewController() -> MovieQuizViewController {
            let controller = MovieQuizViewController()
            return controller
    }
}
