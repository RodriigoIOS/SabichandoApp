import Foundation

final class QuizViewModel {
    private(set) var questions: [Question] = [
        Question(question: "Qual é a capital do Brasil?", options: ["Rio de Janeiro", "Brasília", "São Paulo", "Salvador"], correctAnswerIndex: 1),
        Question(question: "Quanto é 2 + 2?", options: ["3", "4", "5", "6"], correctAnswerIndex: 1),
        Question(question: "Quem descobriu o Brasil?", options: ["Cristóvão Colombo", "Pedro Álvares Cabral", "Dom Pedro I", "Tiradentes"], correctAnswerIndex: 1)
    ]
    
    private(set) var currentQuestionIndex = 0
    private(set) var correctAnswersCount = 0
    
    var onQuizCompleted: ((Int, Int) -> Void)?
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    func optionSelected(at index: Int) {
        guard let question = currentQuestion else { return }
        
        if index == question.correctAnswerIndex {
            correctAnswersCount += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.moveToNextQuestion() {
                NotificationCenter.default.post(name: .didMoveToNextQuestion, object: nil)
            } else {
                self.onQuizCompleted?(self.correctAnswersCount, self.questions.count)
            }
        }
    }
    
    func moveToNextQuestion() -> Bool {
        currentQuestionIndex += 1
        return currentQuestionIndex < questions.count
    }
}

extension Notification.Name {
    static let didMoveToNextQuestion = Notification.Name("didMoveToNextQuestion")
}
