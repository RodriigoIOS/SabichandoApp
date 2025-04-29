import UIKit

final class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModel
    
    private let questionLabel = UILabel()
    private var optionsStackView = UIStackView()

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .didMoveToNextQuestion, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        showCurrentQuestion()
    }
    
    private func setupLayout() {
        questionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        
        view.addSubview(questionLabel)
        view.addSubview(optionsStackView)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func showCurrentQuestion() {
        guard let question = viewModel.currentQuestion else { return }
        
        questionLabel.text = question.question
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, option) in question.options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 8
            button.tag = index
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        viewModel.optionSelected(at: sender.tag)
    }
    
    @objc private func updateUI() {
        showCurrentQuestion()
    }
}
