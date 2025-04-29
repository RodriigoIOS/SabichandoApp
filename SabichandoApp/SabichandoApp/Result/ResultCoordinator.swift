//
//  ResultCoordinator.swift
//  SabichandoApp
//
//  Created by Rodrigo on 24/04/25.
//
import UIKit

final class ResultCoordinator {
    var navigationController: UINavigationController
    private let correctAnswers: Int
    private let totalQuestions: Int
    var onPlayAgain: (() -> Void)?
    
    init(navigationController: UINavigationController, correctAnswers: Int, totalQuestions: Int) {
        self.navigationController = navigationController
        self.correctAnswers = correctAnswers
        self.totalQuestions = totalQuestions
    }
    
    func start() {
        let viewModel = ResultViewModel(correctAnswers: correctAnswers, totalQuestions: totalQuestions)
        let viewController = ResultViewController(viewModel: viewModel)
        
        viewModel.onPlayAgain = { [weak self] in
            self?.onPlayAgain?()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
