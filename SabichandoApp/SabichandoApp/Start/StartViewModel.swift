//
//  StartViewModel.swift
//  SabichandoApp
//
//  Created by Rodrigo on 24/04/25.
//

import Foundation

final class StartViewModel {
    var onStartButtonTapped: (() -> Void)?
    
    func startButtonTapped() {
        print("bloco da funcao startButtonTapped recebida")
        onStartButtonTapped?()
    }
}
