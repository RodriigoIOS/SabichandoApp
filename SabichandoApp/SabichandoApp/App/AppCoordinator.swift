import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showStart()
    }
    
    private func showStart() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        
        startCoordinator.onStartQuiz = { [weak self] in
            print("coordinator recebeu a mensagem e vai mostrar o ShowQuiz")
            self?.showQuiz()
        }
        startCoordinator.start()
    }
    
    private func showQuiz() {
        let quizCoordinator = QuizCoordinator(navigationController: navigationController)
        
        quizCoordinator.onQuizCompleted = { [weak self] correctAnswers, totalQuestions in
            self?.showResult(correctAnswers: correctAnswers, totalQuestions: totalQuestions)
        }
        
        quizCoordinator.start()
    }
    
    private func showResult(correctAnswers: Int, totalQuestions: Int) {
        let resultCoordinator = ResultCoordinator(
            navigationController: navigationController,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions
        )
        
        resultCoordinator.onPlayAgain = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
        }
        
        resultCoordinator.start()
    }
}
