//
//  QuizViewModel.swift
//  SabichandoApp
//
//  Created by Rodrigo on 15/04/25.
//

import Foundation

final class QuizViewModel {
    
    private(set) var questions: [Question] = []
    private(set) var currentQuestionIndex: Int = 0
    var correctAnswersCount = 0
    var totalQuestions: Int {
        return questions.count
    }

    var currentQuestion: Question {
        return questions[currentQuestionIndex]
    }
    
    init() {
        loadMockQuestion()
    }
    
    func loadMockQuestion() {
        questions = [
            Question(title: "Qual é a capital do Brasil?",
                     options: ["Rio de Janeiro", "São Paulo", "Brasilia", "Salvador"],
                     correctAnswerIndex: 2),
            
            Question(title: "Quem pintou a Mona Lisa",
                     options: ["Van Gogh", "Da Vinci", "Picasso", "Michelangelo"],
                     correctAnswerIndex: 1),
    
            Question(title: "Swift é uma linguagem de ...",
                     options: ["Back-end", "Front-end", "Mobile", "Banco de dados"],
                     correctAnswerIndex: 2)
        ]
    }
    
    func moveToNextQuestion() -> Bool {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
            return true
        } else {
            return false
        }
    }
    
    func isCorrectAnswer(_ index: Int) -> Bool {
        let isCorrect = currentQuestion.correctAnswerIndex == index
        if isCorrect { correctAnswersCount += 1 }
        return isCorrect
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
    }
}
