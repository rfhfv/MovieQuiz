import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    // MARK: - Private Properties
    
    private var presenter: MovieQuizPresenter?
    lazy var movieQuizView = MovieQuizView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = movieQuizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieQuizView.noButton.addTarget(self, action: #selector(tappedNo), for: .touchUpInside)
        movieQuizView.yesButton.addTarget(self, action: #selector(tappedYes), for: .touchUpInside)
        
        presenter = MovieQuizPresenter(viewController: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func tappedNo() {
        presenter?.tappedNo()
    }
    
    @objc private func tappedYes() {
        presenter?.tappedYes()
    }
    
    func show(quiz step: QuizStepViewModel) {
        movieQuizView.quizImage.image = step.image
        movieQuizView.questionTextLabel.text = step.question
        movieQuizView.counterLabel.text = step.questionNumber
    }
    
    func show(quiz result: QuizResultViewModel) {
        let message = presenter?.makeResultsMessage()
        
        let alert = UIAlertController(
            title: result.title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: result.buttonText,
            style: .default
        ){ [weak self] _ in
            guard let self = self else { return }
            self.presenter?.restartGame()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func highLightImageBorder(isCorrectAnswer: Bool) {
        movieQuizView.quizImage.layer.masksToBounds = true
        movieQuizView.quizImage.layer.borderWidth = 8
        movieQuizView.quizImage.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.movieQuizView.quizImage.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func showLoadingIndicator() {
        movieQuizView.activityIndicator.isHidden = false
        movieQuizView.activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        movieQuizView.activityIndicator.isHidden = true
        movieQuizView.activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "Попробовать еще раз",
            style: .default
        ){ [weak self] _ in
            guard let self = self  else { return }
            self.presenter?.restartGame()
        }
        alert.addAction(action)
    }
}
