import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    // MARK: - Lifecycle
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    
    private var alertPresenter: AlertPresenter?
    private var presenter: MovieQuizPresenter!
    
    // MARK: - Public Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        alertPresenter = AlertPresenter(alertPresenterDelegate: self)
        presenter = MovieQuizPresenter(viewController: self)
    }
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        yesButton.isEnabled = false
        
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        noButton.isEnabled = false
        
        presenter.noButtonClicked()
    }
    
    // MARK: - Private functions
    
    func highlightImageBorder(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        if isCorrect {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let errorAlert = AlertModel(title: "Что-то пошло не так(",
                                    message: "Невозможно загрузить данные",
                                    buttonText: "Попробовать еще раз")
        { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        
        imageView.layer.borderWidth = 0
        alertPresenter?.show(alertModel: errorAlert)
    }
    
    func show(quiz step: QuizStepViewModel) {
        noButton.isEnabled = true
        yesButton.isEnabled = true
        imageView.layer.borderWidth = 0
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func show(quiz result: QuizResultsViewModel) {
        let resultAlert = AlertModel(
            title: result.title,
            message: presenter.message(),
            buttonText: result.buttonText)
        { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        alertPresenter?.show(alertModel: resultAlert)
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
}
