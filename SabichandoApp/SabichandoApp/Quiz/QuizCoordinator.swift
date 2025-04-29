
import UIKit

final class QuizCoordinator {
    let navigationController: UINavigationController
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
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
