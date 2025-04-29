//
//  ResultViewModel.swift
//  SabichandoApp
//
//  Created by Rodrigo on 24/04/25.
//

import Foundation

final class ResultViewModel {
    let correctAnswers: Int
    let totalQuestions: Int
    var onPlayAgain: (() -> Void)?
    
    init(correctAnswers: Int, totalQuestions: Int) {
        self.correctAnswers = correctAnswers
        self.totalQuestions = totalQuestions
    }
    
    func playAgainTapped() {
        onPlayAgain?()
    }
}
