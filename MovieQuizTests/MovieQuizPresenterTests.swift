//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by admin on 20.08.2025.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    var movieQuizView: MovieQuizView
    
    init(movieQuizView: MovieQuizView) {
        self.movieQuizView = movieQuizView
    }
    
    func highLightImageBorder(isCorrectAnswer: Bool) {
        
    }
    
    func show(quiz step: QuizStepViewModel) {
    
    }
    
    func show(quiz result: QuizResultViewModel) {
    
    }
    
    func showLoadingIndicator() {
    
    }
    
    func hideLoadingIndicator() {
    
    }
    
    func showNetworkError(message: String) {
    
    }
}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let movieQuizViewInstance = MovieQuizView()
        let viewControllerMock = MovieQuizViewControllerMock(movieQuizView: movieQuizViewInstance)
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
         XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
