//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by admin on 20.08.2025.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    var movieQuizView: MovieQuizView { get }
    
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultViewModel)
    
    func highLightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
