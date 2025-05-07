
import UIKit

final class QuizCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var onQuizCompleted: ((Int, Int) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = QuizViewModel()
        let viewController = QuizViewController(viewModel: viewModel)
        
        viewModel.onQuizCompleted = { [weak self] correctAnswers, totalQuestions in
            self?.onQuizCompleted?(correctAnswers, totalQuestions)
        }
        
        print("Antes do push - Stack: \(navigationController.viewControllers.count)")
//        navigationController.pushViewController(viewController, animated: true)
        navigationController.setViewControllers([viewController], animated: true)

        print("Depois do push - Stack: \(navigationController.viewControllers.count)")
    }
}
