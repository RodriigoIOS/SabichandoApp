//
//  StartCoordinator.swift
//  SabichandoApp
//
//  Created by Rodrigo on 24/04/25.
//

import UIKit

class StartCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var onStartQuiz: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = StartViewModel()
        let viewController = StartViewController(viewModel: viewModel)
        print("🎯 StartCoordinator start chamado - instância: \(Unmanaged.passUnretained(self).toOpaque())")

        
        viewModel.onStartButtonTapped = { [weak self] in
            print("🚀 StartCoordinator recebeu o evento de botão")
            self?.onStartQuiz?()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
        
    }
}
