//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 24.02.2023.
//

import UIKit

class AlertPresenter {
    
    let alertPresenterDelegate: MovieQuizViewController
    
     func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default)
         
        alert.addAction(action)
         alertPresenterDelegate.present(alert, animated: true, completion: alertModel.completion)
    }
    
    init(alertPresenterDelegate: MovieQuizViewController) {
        self.alertPresenterDelegate = alertPresenterDelegate
    }
}
