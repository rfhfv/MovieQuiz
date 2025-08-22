//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by admin on 15.08.2025.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date

    func isBetterThan(_ another: GameRecord) -> Bool {
           correct > another.correct
       }
}
