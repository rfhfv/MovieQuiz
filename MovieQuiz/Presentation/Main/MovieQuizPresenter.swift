//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by admin on 18.08.2025.
//

import UIKit

final class MovieQuizPresenter {
    private let questionsAmount = 10
    private var correctAnswers = 0
    private var currentQuestionIndex = 0
    
    private let statisticService: StatisticService
    private var currentQuestion: QuizQuestion?
    private var questionFactory: QuestionFactoryProtocol?
    private weak var viewController: MovieQuizViewControllerProtocol?
    
    init(viewController: MovieQuizViewControllerProtocol?) {
        self.viewController = viewController
        statisticService = StatisticServiceImpl()
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        viewController?.showLoadingIndicator()
        questionFactory?.loadData()
    }
    
    func isLastQUestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }
    
    @objc func tappedYes() {
        didAnswer(isYes: true)
        viewController?.movieQuizView.yesButton.backgroundColor = .ypGray
        viewController?.movieQuizView.yesButton.setTitleColor(.ypDarkGray, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewController?.movieQuizView.yesButton.backgroundColor = .ypWhite
            self.viewController?.movieQuizView.yesButton.setTitleColor(.ypBlack, for: .normal)
        }
    }
    
    @objc func tappedNo() {
        didAnswer(isYes: false)
        viewController?.movieQuizView.noButton.backgroundColor = .ypGray
        viewController?.movieQuizView.noButton.setTitleColor(.ypDarkGray, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewController?.movieQuizView.noButton.backgroundColor = .ypWhite
            self.viewController?.movieQuizView.noButton.setTitleColor(.ypBlack, for: .normal)
        }
    }
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = isYes
        self.proceedWithanswer(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    func didAnswered(isCorrectAnswer: Bool) {
        if isCorrectAnswer {
            correctAnswers += 1
        }
    }
    
    func proceedWithanswer(isCorrect: Bool) {
        didAnswered(isCorrectAnswer: isCorrect)
        
        viewController?.highLightImageBorder(isCorrectAnswer: isCorrect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.proceedToNextQuestionOrResults()
        }
    }
    
    func proceedToNextQuestionOrResults() {
        if self.isLastQUestion() {
            let text = "Вы ответили на \(correctAnswers) из 10, попробуйте еще раз!"
            let viewModel = QuizResultViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            viewController?.show(quiz: viewModel)
        } else {
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    func makeResultsMessage() -> String {
        statisticService.store(correct: correctAnswers, total: questionsAmount)
        
        let bestGame = statisticService.bestGame
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(correctAnswers)/\(questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)/\(bestGame.total)"
        + " (\(bestGame.date.dateTimeString))"
        let averageAccuracyLine = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"
        
        let components: [String] = [
            currentGameResultLine,
            totalPlaysCountLine,
            bestGameInfoLine,
            averageAccuracyLine
        ]
        let resultMessage = components.joined(separator: "\n")
        return resultMessage
    }
}

// MARK: - QuestionFactoryDelegate

extension MovieQuizPresenter: QuestionFactoryDelegate {
    
    func didReceiveNextQuestion(_ question: QuizQuestion?) {
        guard let question = question else { return }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
        viewController?.hideLoadingIndicator()
    }
    
    func didLoadDataFormServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToloadData(with error: Error) {
        let message = error.localizedDescription
        viewController?.showNetworkError(message: message)
    }
}
