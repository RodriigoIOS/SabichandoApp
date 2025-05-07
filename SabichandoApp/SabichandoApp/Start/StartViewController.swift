//
//  StartViewController.swift
//  SabichandoApp
//
//  Created by Rodrigo on 21/04/25.
//

import UIKit

class StartViewController: UIViewController {
    
    let viewModel: StartViewModel
    
    init(viewModel: StartViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sabichando v1"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mostre que vossê sabo muito!!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white
                             , for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, startButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    @objc private func startTapped() {
        print("Botao foi pressionado com sucesso")
        viewModel.startButtonTapped()
    }
}
