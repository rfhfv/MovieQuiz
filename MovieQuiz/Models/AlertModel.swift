//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by admin on 15.08.2025.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
}
