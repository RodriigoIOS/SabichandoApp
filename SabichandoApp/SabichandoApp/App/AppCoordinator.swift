import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        print("📌 StartCoordinator instância: \(Unmanaged.passUnretained(startCoordinator).toOpaque())")

        startCoordinator.onStartQuiz = {
            print("Callback do botão Start chegou no AppCoordinator")
            self.showQuiz()
        }
        
        self.childCoordinators.append(startCoordinator)

        startCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
    func showQuiz() {
        print("🔁 Chamando showQuiz()")
        let quizCoordinator = QuizCoordinator(navigationController: navigationController)
        
        quizCoordinator.onQuizCompleted = { correctAnswers, totalQuestions in
            self.showResult(correctAnswers: correctAnswers, totalQuestions: totalQuestions)
        }
        
        quizCoordinator.start()
    }
    
    private func showResult(correctAnswers: Int, totalQuestions: Int) {
        let resultCoordinator = ResultCoordinator(
            navigationController: navigationController,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions
        )
        
        resultCoordinator.onPlayAgain = {
            self.navigationController.popToRootViewController(animated: true)
        }
        
        resultCoordinator.start()
    }
}
