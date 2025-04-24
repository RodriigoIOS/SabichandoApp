import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - Properties
    private let totalQuestions: Int
    private let correctAnswers: Int
    var onPlayAgain: (() -> Void)?
    
    // MARK: - UI Elements
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let playAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Jogar Novamente", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    // MARK: - Init
    init(totalQuestions: Int, correctAnswers: Int) {
        self.totalQuestions = totalQuestions
        self.correctAnswers = correctAnswers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
        showResult()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [resultLabel, playAgainButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupActions() {
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
    }
    
    private func showResult() {
        let percentage = Int((Double(correctAnswers) / Double(totalQuestions)) * 100)
        
        if percentage > 70 {
            resultLabel.text = "Você acertou \(correctAnswers) de \(totalQuestions) perguntas.\n\nCarai, tu é o bixão, sabo muito: \(percentage)%"
        }else {
            resultLabel.text = "Você acertou \(correctAnswers) de \(totalQuestions) perguntas.\n\nTu é burro mano, fez só: \(percentage)%"
        }
        
    }
    
    @objc private func playAgainTapped() {
        dismiss(animated: true) {
            self.onPlayAgain?()
        }
    }
}
