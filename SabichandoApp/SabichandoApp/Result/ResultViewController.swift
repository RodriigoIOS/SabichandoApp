import UIKit

final class ResultViewController: UIViewController {
    
    private let viewModel: ResultViewModel
    
    private let resultLabel = UILabel()
    private let playAgainButton = UIButton(type: .system)
    
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configure()
    }
    
    private func setupLayout() {
        view.addSubview(resultLabel)
        view.addSubview(playAgainButton)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            playAgainButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 40),
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.widthAnchor.constraint(equalToConstant: 200),
            playAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        playAgainButton.addTarget(self, action: #selector(playAgainButtonTapped), for: .touchUpInside)
        
        resultLabel.font = UIFont.boldSystemFont(ofSize: 28)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        
        playAgainButton.setTitle("Jogar Novamente", for: .normal)
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        playAgainButton.backgroundColor = .systemBlue
        playAgainButton.tintColor = .white
        playAgainButton.layer.cornerRadius = 10
    }
    
    private func configure() {

        let percentage = Int((Double(viewModel.correctAnswers) / Double(viewModel.totalQuestions)) * 100)
        
            if percentage > 70 {
                resultLabel.text = "Você acertou \(viewModel.correctAnswers) de \(viewModel.totalQuestions) perguntas.\n\nCarai, tu é o bixão, sabo muito: \(percentage)%"
            }else {
                resultLabel.text = "Você acertou \(viewModel.correctAnswers) de \(viewModel.totalQuestions) perguntas.\n\nTu é burro mano, fez só: \(percentage)%"
            }
    }
    
    @objc private func playAgainButtonTapped() {
        viewModel.playAgainTapped()
    }
}
