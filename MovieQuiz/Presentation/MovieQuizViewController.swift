import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    private var currentQuestionIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private let questions: [QuizQuestion] = [QuizQuestion(image: "The Godfather",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "The Dark Knight",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "Kill Bill",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "The Avengers",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "Deadpool",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "The Green Knight",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: true),
                                             QuizQuestion(image: "Old",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: false),
                                             QuizQuestion(image: "The Ice Age Adventures of Buck Wild",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: false),
                                             QuizQuestion(image: "Tesla",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: false),
                                             QuizQuestion(image: "Vivarium",
                                                          text: "Рейтинг этого фильма больше чем 6?",
                                                          correctAnswer: false),
    ]
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        let currentQuestion: QuizQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    private func showAnswerResult(isCorrect: Bool) {
       
        imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
        imageView.layer.borderWidth = 1 // толщина рамки
        imageView.layer.cornerRadius = 6 // радиус скругления углов рамки
        
        if isCorrect == true {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
    }
    
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    private func show(quiz result: QuizResultsViewModel) {
      // здесь мы показываем результат прохождения квиза
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
    
}

struct QuizQuestion {
  let image: String
  let text: String
  let correctAnswer: Bool
}

// для состояния "Вопрос задан"
struct QuizStepViewModel {
  let image: UIImage
  let question: String
  let questionNumber: String
}

// для состояния "Результат квиза"
struct QuizResultsViewModel {
  let title: String
  let text: String
  let buttonText: String
}




/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
