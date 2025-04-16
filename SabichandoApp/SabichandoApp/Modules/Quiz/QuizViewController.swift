//
//  ViewController.swift
//  SabichandoApp
//
//  Created by Rodrigo on 14/04/25.
//

import UIKit

class QuizViewController: UIViewController {
    
    private let viewModel = QuizViewModel()
    private var optionButtons: [UIButton] = []
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Pergunta vai aqui"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLayout()
        showCurrentQuestion()
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        
        //StackView principal
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(questionLabel)
        
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.tag = i
            button.setTitle("Opção \(i+1)", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            optionButtons.append(button)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showCurrentQuestion() {
        let question = viewModel.currentQuestion
        questionLabel.text = question.title
        
        for (index, option) in question.options.enumerated() {
            if index < optionButtons.count {
                optionButtons[index].setTitle(option, for: .normal)
                optionButtons[index].isHidden = false
            }
        }
        for i in question.options.count..<optionButtons.count {
            optionButtons[i].isHidden = true
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton){
        let index = sender.tag
        let isCorrect = viewModel.isCorrectAnswer(index)
        
        print(isCorrect ? "Acertou!" : "Errou!")
        
        if viewModel.moveToNextQuestion() {
            showCurrentQuestion()
        } else {
            print("Quiz Finalizado!")
        }
    }
}
