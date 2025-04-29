//
//  StartCoordinator.swift
//  SabichandoApp
//
//  Created by Rodrigo on 24/04/25.
//

import UIKit

final class StartCoordinator {
    
    let navigationController: UINavigationController
    var onStartQuiz: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = StartViewModel()
        let viewController = StartViewController(viewModel: viewModel)
        
        viewModel.onStartButtonTapped = { [weak self] in
            print("bloco da funcao dentro do StartCoordinator funcionou com sucesso")
            self?.onStartQuiz?()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
