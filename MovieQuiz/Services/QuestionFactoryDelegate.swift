//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by admin on 14.08.2025.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(_ question: QuizQuestion?)
    func didLoadDataFormServer()
    func didFailToloadData(with error: Error)
}
