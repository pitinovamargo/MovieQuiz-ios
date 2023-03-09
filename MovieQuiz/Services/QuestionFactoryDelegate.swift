//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 23.02.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
