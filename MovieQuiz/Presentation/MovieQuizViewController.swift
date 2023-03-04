import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    // MARK: - Lifecycle

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    
    private var alertPresenter: AlertPresenter?
    private var statisticService: StatisticService = StatisticServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory(delegate: self)
        questionFactory?.requestNextQuestion()
        
        alertPresenter = AlertPresenter(alertPresenterDelegate: self)
    }
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
              return
          }
          
          currentQuestion = question
          let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
                self?.show(quiz: viewModel)
            }
    }
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        yesButton.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        noButton.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    // MARK: - Private functions
    
    private func showAnswerResult(isCorrect: Bool) {
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        
        if isCorrect {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            correctAnswers += 1
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
        }
    }
        
    private func showNextQuestionOrResults() {
      if currentQuestionIndex == questionsAmount - 1 {
          statisticService.store(correct: self.correctAnswers, total: self.questionsAmount)
          let resultAlert = AlertModel(
                                title: "Этот раунд окончен",
                                message: "Ваш результат: \(correctAnswers)/\(questionsAmount)\n Количество сыгранных квизов: \(statisticService.gamesCount)\n Рекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total) (\(statisticService.bestGame.date.dateTimeString))\n Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy * 100))%",
                                buttonText: "Сыграть еще раз")
                                { [weak self] in
                                    guard let self = self else { return }

                                    self.currentQuestionIndex = 0
                                    self.correctAnswers = 0

                                    self.questionFactory?.requestNextQuestion()
                                }
          imageView.layer.borderWidth = 0

          alertPresenter?.show(alertModel: resultAlert)
      } else {
          currentQuestionIndex += 1
          imageView.layer.borderWidth = 0

          questionFactory?.requestNextQuestion()
          noButton.isEnabled = true
          yesButton.isEnabled = true
      }
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
}
